//
//  MVVMPageViewController.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 26/9/25.
//

import UIKit

final class MVVMPageViewController: UIPageViewController {

    private lazy var pages: [UIViewController] = [
        MVVMCombineCounterViewController(),
        MVVMDelegateCounterViewController(),
        MVVMObservableCounterViewController()
    ]

    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.hidesForSinglePage = true
        return control
    }()

    private var currentIndex = 0

    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        view.backgroundColor = .systemBackground

        configurePageControl()
        displayPage(at: 0, direction: .forward, animated: false)
    }

    private func configurePageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = currentIndex
        pageControl.pageIndicatorTintColor = .secondaryLabel
        pageControl.currentPageIndicatorTintColor = .label
        if #available(iOS 14.0, *) {
            pageControl.backgroundStyle = .prominent
        }
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
        view.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            pageControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }

    private func displayPage(at index: Int, direction: NavigationDirection, animated: Bool) {
        guard pages.indices.contains(index) else { return }
        let controller = pages[index]
        setViewControllers([controller], direction: direction, animated: animated)
        controller.loadViewIfNeeded()
        updateCurrentPage(to: index)
    }

    private func updateCurrentPage(to index: Int) {
        guard pages.indices.contains(index) else { return }
        currentIndex = index
        pageControl.currentPage = index
        title = pages[index].title
    }

    private func index(of viewController: UIViewController) -> Int? {
        pages.firstIndex { $0 === viewController }
    }

    @objc private func pageControlChanged(_ sender: UIPageControl) {
        let targetIndex = sender.currentPage
        let direction: NavigationDirection = targetIndex >= currentIndex ? .forward : .reverse
        displayPage(at: targetIndex, direction: direction, animated: true)
    }
}

extension MVVMPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = index(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = index(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let current = viewControllers?.first else { return 0 }
        return index(of: current) ?? 0
    }
}

extension MVVMPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let current = viewControllers?.first, let index = index(of: current) else { return }
        current.loadViewIfNeeded()
        updateCurrentPage(to: index)
    }
}
