//
//  PostsViewModel.swift
//  SocialAcademy
//
//  Created by Bashir Adeniran on 5/25/25.
//

import Foundation

@MainActor
class PostsViewModel: ObservableObject {
    enum Filter {
        case all, author(User), favorites
    }
    
    var title: String {
        switch filter {
        case .all:
            return "Post"
        case let .author(author):
            return "\(author.name)'s Posts"
        case .favorites:
            return "Favorites"
        }
    }
    
    
    @Published var posts: Loadable<[Post]> = .loading
    private let postsRepository: PostsRepositoryProtocol
    
    private let filter: Filter
    
    init(filter: Filter = .all, postsRepository: PostsRepositoryProtocol) {
        self.postsRepository = postsRepository
        self.filter = filter
    }
    
    func fetchPosts() {
        Task {
            do {
                posts = .loaded(try await postsRepository.fetchPosts(matching: filter))
            } catch {
                print("[PostViewModel] Cannot fetch posts: \(error)")
                posts = .error(error)
            }
        }
    }
    
    func makePostRowViewModel(for post: Post) -> PostRowViewModel {
        let deleteAction = { [weak self] in
            try await self?.postsRepository.delete(post)
            self?.posts.value?.removeAll { $0 == post }
        }
        let favoriteAction = { [weak self] in
            let newValue = !post.isFavorite
            try await newValue ? self?.postsRepository.favorite(post) : self?.postsRepository.unfavorite(post)
            guard let i = self?.posts.value?.firstIndex(of: post) else { return }
            self?.posts.value?[i].isFavorite = newValue
        }
        return PostRowViewModel(post: post, deleteAction: postsRepository.canDelete(post) ? deleteAction : nil, favoriteAction: favoriteAction)
    }
    
    func makeNewPostViewModel() -> FormViewModel<Post> {
        return FormViewModel( initialValue: Post(title:"", content: "", author: postsRepository.user),
                              action: { [weak self] post in
            try await self?.postsRepository.create(post)
            self?.posts.value?.insert(post, at: 0)
        }
        )
    }
}

