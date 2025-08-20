//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Данила Спиридонов on 03.06.2025.
//

import UIKit

final class ProfileViewController: UIViewController {
        
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let loginNameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let logoutButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        if let profile = ProfileService.shared.profile {
            updateProfileDetails(profile: profile)
        }
    }
    
    private func setupViews() {
        let profileImage = UIImage(named: "userpickPhoto")
        avatarImageView.image = profileImage
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor)
        ])
        
        loginNameLabel.text = "@ekaterina_nov"
        loginNameLabel.textColor = UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1)
        loginNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginNameLabel)
        NSLayoutConstraint.activate([
            loginNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            loginNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor)
        ])
        
        descriptionLabel.text = "Hello, World!"
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor)
        ])
        
        
        logoutButton.setImage(UIImage(systemName: "ipad.and.arrow.forward"), for: .normal)
        logoutButton.tintColor = UIColor(red: 0.9608, green: 0.4196, blue: 0.4235, alpha: 1)
        logoutButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            logoutButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }
    
    private func updateProfileDetails(profile: Profile) {
        nameLabel.text = profile.name.isEmpty ? "Имя не указано" : profile.name
        loginNameLabel.text = profile.loginName.isEmpty ? "@неизвестный_пользователь" : profile.loginName
        descriptionLabel.text = (profile.bio?.isEmpty ?? true) ? "Профиль не заполнен" : profile.bio
    }
    
    @objc
    private func didTapButton() {
        
    }
}
