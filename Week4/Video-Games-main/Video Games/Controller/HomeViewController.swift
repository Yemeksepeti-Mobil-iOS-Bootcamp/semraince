import UIKit
import Kingfisher

class HomeViewController: UIViewController{
    
    //PageView
    @IBOutlet weak var pageControl: UIPageControl!
    private var pages = [UIViewController]()
    private var pageCount: Int = 3
    private var pageViewController: UIPageViewController?
    private var currentIndex = 0
    private var pendingIndex: Int?
    
    //CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    private var collectionData = [VideoGame]()
    private var chosenVideoGameSlug = ""
    
    //This stackview only used for "isHidden" property
    //to show/hide onSearch
    @IBOutlet weak var stackView: UIStackView!
    
    //Search Text Field
    @IBOutlet weak var searchText: UITextField!

    //NetworkConnection
    private let network = APINetwork()
    
    private let noItemTextLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        noItemTextLabel.isHidden = true
        
        network.delegate = self
        network.fetchData()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        searchText.delegate = self
                        
        //Init collectionView with custom cell
        self.collectionView.register(UINib.init(nibName: "VideoGameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "videoGameCell")
        
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.currentPageIndicatorTintColor = .label
        /*pageView.addGestureRecognizer(gesture);
        pageView.isUserInteractionEnabled = true;*/
        stackView.addGestureRecognizer(gesture)
        stackView.isUserInteractionEnabled = true;
    }
    
    
    @IBOutlet weak var pageView: UIView!
    let gesture = UITapGestureRecognizer(target: self, action:  #selector(clickAction(_:)));
    
    
    
    
    @objc func clickAction(_ sender : UITapGestureRecognizer) {
        print("girdims")
    }
    
    
    
    func pageControllerInit(videoGameList: [VideoGame]) {
        for i in 0 ..< pageCount {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as? PageContentViewController {
                vc.videoGameImage = videoGameList[i].background_image
                pages.append(vc)
            }
        }
        pageViewController = self.children[0] as? UIPageViewController
        pageViewController!.delegate = self
        pageViewController!.dataSource = self
        pageViewController!.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        pageControl.numberOfPages = pageCount
    }
    
    
    //TextField value
    @IBAction func searchTextChanged(_ sender: UITextField) {
        if let text = sender.text {
            
            //If there is more than 3 characters
            //Hide UIPageView
            //Expand CollectionView to bottom of search text
            if text.count >= 4 {
                self.view.willRemoveSubview(noItemTextLabel)
                noItemTextLabel.isHidden = true
                stackView.isHidden = true
                collectionView.isHidden = false
                collectionData.removeAll()
                collectionView.reloadData()
                collectionData = network.baseData.filter{
                    $0.name.lowercased().contains(text.lowercased())
                }
                
                //When collectionView's frame changed
                //It needs an update
                collectionView.layoutIfNeeded()
                collectionView.reloadData()
                
                //If there is no book,
                //Show only text at center
                if collectionData.count == 0 {
                    stackView.isHidden = true
                    collectionView.isHidden = true
                    noItemTextLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
                    noItemTextLabel.center = self.view.center
                    noItemTextLabel.text = "Sorry, there is no video game"
                    noItemTextLabel.textAlignment = .center
                    noItemTextLabel.textColor = .label
                    //noItemTextLabel.tintColor = .black
                    noItemTextLabel.isHidden = false
                    self.view.addSubview(noItemTextLabel)
                }
            }else if text.count == 0 {
                self.view.willRemoveSubview(noItemTextLabel)
                sender.text = ""
                noItemTextLabel.isHidden = true
                stackView.isHidden = false
                collectionView.isHidden = false
                
                collectionData.removeAll()
                collectionView.reloadData()
                collectionData = Array(network.baseData[self.pageCount..<network.baseData.count])
                
                //Adjust constraints
                collectionView.layoutIfNeeded()
                collectionView.reloadData()
            }
        }
    }
    
    
}

extension HomeViewController: UITextFieldDelegate {
    
    //On return button (keyboard)
    //If text char number is less than 4
    //show main view
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let currentText = textField.text {
            if currentText.count < 4 {
                textField.text = ""
                resetView()
            }
        }
        return true
    }
    
    
    //Show main view
    //If text field is cleared
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        resetView()
        return true
    }
    
    func resetView() {
        noItemTextLabel.isHidden = true
        stackView.isHidden = false
        collectionView.isHidden = false
        collectionData = Array(network.baseData[self.pageCount..<network.baseData.count])
        collectionView.layoutIfNeeded()
        collectionView.reloadData()
    }
}


//PageView extension
extension HomeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.firstIndex(of: viewController)!
        if currentIndex == pages.count - 1 {
            return nil
        }
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.firstIndex(of: viewController)!
        if currentIndex == 0 {
            return nil
        }
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = pages.firstIndex(of: pendingViewControllers.first!)
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let pendingIndex = pendingIndex {
                currentIndex = pendingIndex
                pageControl.currentPage = currentIndex
            }
        }
    }
}


//Collection View
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoGameCell", for: indexPath) as! VideoGameCollectionViewCell
        
        cell.label.text = collectionData[indexPath.row].name
        cell.imageView.kf.indicatorType = .activity
        cell.imageView.kf.setImage(with: URL(string: collectionData[indexPath.row].background_image))
        cell.ratingLabel.text = String(collectionData[indexPath.row].rating)
        cell.dateLabel.text = collectionData[indexPath.row].released
        
        //cell.layer.shadowColor = UIColor.darkGray.cgColor

        return cell
    }
    
    //On tap collectionView cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosenVideoGameSlug = collectionData[indexPath.row].slug
        self.performSegue(withIdentifier: "goToDetailView", sender: self)
    }
    //Pass data with segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailView" {
            if let detailVC = segue.destination as? DetailsViewController {
                detailVC.urlParameter = chosenVideoGameSlug
            }
        }
    }
}



//Notify CollectionData Changes -Delegate
extension HomeViewController: APINetworkDelegate {
    func didUpdateVideoGames(_ apiNetwork: APINetwork, videoGames: [VideoGame]) {
        DispatchQueue.main.async {
            self.pageControllerInit(videoGameList: Array(videoGames[0..<self.pageCount]))
            self.collectionData = Array(videoGames[self.pageCount..<videoGames.count])
            self.collectionView.reloadData()
        }
    }
}
