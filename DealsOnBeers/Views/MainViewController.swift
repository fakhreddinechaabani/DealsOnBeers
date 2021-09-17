//
//  MainViewController.swift
//  DealsOnBeers
//
//  Created by fakhreddine chaabani on 2/25/19.
//  Copyright © 2019 fakhreddine chaabani. All rights reserved.
//import UIKit

import Firebase
import Mapbox
import CoreLocation
import Foundation
import MapKit
import UIKit
import FirebaseFirestore
import Cosmos
import TinyConstraints
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn



class MainViewController: UIViewController, MGLMapViewDelegate, UIGestureRecognizerDelegate,GIDSignInUIDelegate {
    

    
    func login() {
       
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    var handler: AuthStateDidChangeListenerHandle?
    @IBOutlet weak var POPBlur: UIVisualEffectView!
    @IBOutlet weak var labelTypeView: UIView!
    @IBOutlet weak var bottom: UIView!
    var up : Bool = false
    var infoup : Bool = false
    var searchbardragged : Bool = false
    // Favorite attributes
    @IBOutlet weak var FavoriteaddBTN: UIButton!
    @IBOutlet weak var FavoritedeleteBTN: UIButton!
    @IBOutlet weak var Favlabel: UILabel!
    // profile attributes
    @IBOutlet weak var profileV: UIView!
    @IBOutlet weak var profileimg: UIImageView!
     var region : Bool = false
   
    
    @IBOutlet weak var blurverif: UIVisualEffectView!
let v1 = UIView()
    @IBOutlet weak var arrowimgV: UIImageView!
    @IBOutlet weak var photoRoute: UIImageView!
    @IBOutlet weak var photoInfo: UIImageView!
    @IBOutlet weak var photocall: UIImageView!
    @IBOutlet weak var FavoriteImg: UIImageView!
    @IBOutlet weak var FavoriteV: UIView!
    @IBOutlet weak var bottomDetailsLabel: UILabel!
    @IBOutlet weak var InfoBTNView: UIView!
    @IBOutlet weak var RouteView: UIView!
    @IBOutlet weak var CallView: UIView!
 let child = SpinnerViewController()
    @IBOutlet weak var PlaceImgVBtn: UIButton!
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var BottomCosmos: UIView!
    @IBOutlet weak var CosmosView: CosmosView!

    var vprofile = ProfileViewController()
    let darkblue = UIColor.white.cgColor
    let lightpink = UIColor( red: 89.0/255.0, green: 85.0/255.0, blue: 6.0/255.0, alpha: 1.0).cgColor
    let pink = UIColor(red: 0.0/255.0, green: 101.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    struct selectedann {
      static  var  selectedAnno = CustomAnno()
        static var imageprofile = UIImage(named: "profile")
    }
    
    
    @IBOutlet weak var verifaddView: UIView!
    var longitudeSelected : Float = 0.0
    var latitudeSelected : Float = 0.0
    @IBOutlet weak var BannerV: GADBannerView!
    var lastlocation : CLLocationCoordinate2D?
  var incenter = true
    @IBOutlet weak var locationVimg: UIImageView!
    var labelbar = UILabel()
    var labelrestaurant = UILabel()
    @IBOutlet weak var locationview: UIView!
    private let locationManager = CLLocationManager()
    @IBOutlet weak var filterimg: UIImageView!
    @IBOutlet weak var btnlocationimg: UIButton!
    @IBOutlet weak var searchIco: UIView!
    @IBOutlet weak var searchicoimg: UIImageView!
    @IBOutlet weak var InfoView: UIView!
    let VF = verifAnnotation()
    @IBOutlet weak var blurinfo: UIVisualEffectView!
    @IBOutlet weak var mapView: MGLMapView!
    var gradient : CAGradientLayer!
  //  @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var placeimgVIew: UIView!
    
    @IBOutlet weak var filterbtn: UIView!
    @IBOutlet weak var footView: UIView!
    @IBOutlet weak var SearchBarView: UIView!
    @IBOutlet weak var searchBarBlur: UIVisualEffectView!
 
    @IBOutlet weak var searchbv: UIView!
    var filtrestaurant = UIView()
    var filterbar = UIView()
    var filterclothing = UIView()
    let maskLayer1: CAGradientLayer = CAGradientLayer()
    @IBOutlet weak var blurfilter: UIVisualEffectView!
   
    var docref : DocumentReference!
    @IBOutlet weak var LabelTitle: UILabel!
    @IBOutlet weak var placeimgV: UIImageView!
    
    //      let authpop = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthPOP")
    var profileimage = UIImage()
    // HEADER VIEW COMPONENTS
    @IBOutlet weak var LabelType: UILabel!
    @IBOutlet weak var VIewAdr: UIView!
    @IBOutlet weak var LabelAdr: UILabel!
    @IBOutlet weak var ViewOffer: UIView!
    @IBOutlet weak var LabelOffer: UILabel!
    @IBOutlet weak var ViewInfo: UIView!
    @IBOutlet weak var LabelInfo: UILabel!

    

    
   
    override func viewDidLoad() {
             super.viewDidLoad()
        vprofile = (storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as?  ProfileViewController)!
        initcompass()
        
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
         GIDSignIn.sharedInstance().uiDelegate = self
        profileinit()
      
       
        verifphoto()
        
       blurverif.isHidden = true
      
        POPBlur.isHidden = true
        initmap()
     BannerV.adUnitID = "ca-app-pub-3809656994962118/8889288122"
        BannerV.rootViewController = self
        BannerV.load(GADRequest())
        initinfov()
        initblurinfo()
        blurinfo.isHidden = true
        searchicoimg.tintColor = UIColor.lightGray
   
          mapView.delegate = self
        initlocationV()
        mapView.logoView.isHidden = true
        mapView.attributionButton.isHidden = true
        let mapdrag = UIPanGestureRecognizer(target: self, action: #selector (self.diddragmap(gestureRecognizer: )))
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapdrag.delegate = self
        self.mapView.addGestureRecognizer(mapdrag)
    mapView.isPitchEnabled = true
       locationInit()
        initframe()
        searchbarinit()
        btninit(filterb: self.filterbtn)
        blurfilter.isHidden = true
        initViewT()
        view.bringSubviewToFront(placeimgVIew)

    }
    enum ERrorcod: Error  {
        case codezero
    }
func verifphoto() {
    if Auth.auth().currentUser != nil {
        
        if let data = try? Data(contentsOf: (Auth.auth().currentUser?.photoURL)!) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileimg.image = image
                }
            }
        }
    }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
             v1.frame = CGRect(x:0, y:view.bounds.height/10, width: view.bounds.width, height:view.bounds.height - (view.bounds.height/10))
        bottom.addSubview(v1)
        handler = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if Auth.auth().currentUser == nil {
                self.profileimg.image = selectedann.imageprofile
              
            } else if Auth.auth().currentUser != nil {
                self.profileimg.image = selectedann.imageprofile
    
            }
            
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let handler = handler else {return}
        Auth.auth().removeStateDidChangeListener(handler)
    }
    
    

    
    
    
    
   
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var authpop = UIView()
        let touch: UITouch? = touches.first
        if blurinfo.isHidden == false {
        if touch?.view == blurinfo.contentView && touch?.view != placeimgVIew {
             self.mapView.deselectAnnotation(mapView.selectedAnnotations.first, animated: true)
            blurinfo.isHidden = true
          //  UIView.animate(withDuration: 1.0, animations: {
          //      self.InfoView.frame =  self.InfoView.frame.offsetBy(dx: 0, dy: -((self.view.bounds.height/4) * 1.5))
         //   })
        } else if touch?.view == placeimgVIew {
            print("image clicked")
            }
        }
        if touch?.view == BottomCosmos && up == false {
            self.placeimgVIew.isHidden = true
            UIView.animate(withDuration: 1.0, animations: {
         
                self.bottom.frame =  self.bottom.frame.offsetBy(dx: 0, dy: -(self.view.bounds.height-120))
                
            }, completion: {_ in
  
                self.bottomDetailsLabel.text = selectedann.selectedAnno.title
                self.bottomDetailsLabel.textColor = UIColor.white
                self.up = true
                self.arrowimgV.image = UIImage(named: "down_arrow")
                })
        }
          if touch?.view == BottomCosmos && up == true {
            UIView.animate(withDuration: 1.0, animations: {
                
                self.bottom.frame =  self.bottom.frame.offsetBy(dx: 0, dy: (self.view.bounds.height-120))
                
            }, completion: {_ in
                self.bottomDetailsLabel.text = self.VF.starting(times: selectedann.selectedAnno.startH, timee: selectedann.selectedAnno.endH, active: true)
                self.bottomDetailsLabel.textColor = UIColor.white
                self.up = false
                self.placeimgVIew.isHidden = false
                  self.view.bringSubviewToFront(self.placeimgVIew)
                self.arrowimgV.image = UIImage(named: "up_arrow")
            })
        }
       
     
        
     //   if touch?.view == Rateme{ }
      //
        
    }
    
    
    
    
    @IBAction func placeimgbtn(_ sender: UITapGestureRecognizer) {
       let imagev = sender.view as! UIImageView
        let newImage = UIImageView(image: imagev.image)
        newImage.frame = UIScreen.main.bounds
        newImage.backgroundColor = .black
        newImage.contentMode = .scaleAspectFit
        newImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissfsImg))
        newImage.addGestureRecognizer(tap)
        self.view.addSubview(newImage)

    }
    @objc func dismissfsImg(sender: UITapGestureRecognizer) {
    self.view?.removeFromSuperview()
        
    }
    
    
    
    func initmap(){
       
        mapView.view(for: mapView.userLocation!)?.isEnabled = false
        mapView.view(for: mapView.userLocation!)?.isHidden = true
        mapView.userTrackingMode = .followWithCourse
        mapView.showsUserHeadingIndicator = true
        
        
        let inse = addrecord()
       // inse.inserttodb(name: "Crocodile Lounge", lat: "40.7320841", long: "-73.9859311", tit: "Beer", adr: "325 E 14th St, New York, NY 10003", Pne: "(212) 477-7747", desc: "Specials include $4 Coors Light, $5 well drinks, $6 High Life and whiskey, Tecate and tequila. It also offers a free personal pizza when you order a drink ", highlights: " $5 Red Sangria, Mimosa and Thai Beer", pic: "https://pixel.nymag.com/imgs/listings/restaurants/crocodile-lounge/crocodile-lounge-01.w1200.h630.jpg", site: "crocodileloungenyc.com", Times: "1200", TimeE: "1900", d1: true, d2: true, d3: true, d4: true, d5: true, d6: false, d7: false)
        Firestore.firestore().collection("Base").getDocuments() { (document, error) in
                        if error != nil {
                print("error getting documents")
            }
            else {
                            DispatchQueue.main.async {
                                
                            
                for doc in document!.documents {
                    let point = CustomAnno()
                    let nam = doc.get("Name") as! String
                    let lat = doc.get("Latitude") as! String
                    let long = doc.get("Longitude") as! String
                    let tit = doc.get("Category") as! String
            
                    let day1 = doc.get("day1") as! Bool
                    let day2 = doc.get("day2") as! Bool
                    let day3 = doc.get("day3") as! Bool
                    let day4 = doc.get("day4") as! Bool
                    let day5 = doc.get("day5") as! Bool
                    let day6 = doc.get("day6") as! Bool
                    let day7 = doc.get("day7") as! Bool
                   
                    let TimeS = doc.get("timeStart") as! String
                    let TimeE = doc.get("timeEnd") as! String
                    var highlights : String = ""
                    let iD = doc.documentID
                    if doc.get("highlights") != nil {
                        highlights = doc.get("highlights") as! String
                    }else {
                         highlights = ""
                    }
                    point.id = iD
                    point.coordinate = CLLocationCoordinate2D(latitude: Double(lat)! , longitude: Double(long)!)
                    point.Cat = tit
                    point.title = nam
                    point.highlights = highlights
                
                    point.active = self.VF.verifactive(times: TimeS, timee: TimeE, d1: day1, d2: day2, d3: day3, d4: day4, d5: day5, d6: day6,d7: day7)
                    point.startH = TimeS
                    point.endH = TimeE
                    if self.VF.isactivetoaday(d1: day1, d2: day2, d3: day3, d4: day4, d5: day5, d6: day6,d7: day7)
                    {
                        self.mapView.addAnnotation(point)
                    }} } }   }}
    
    @IBAction func infoclicked(_ sender: Any) {
       UIApplication.shared.open(URL(string: selectedann.selectedAnno.site)!)
    }
    
    func initinfov (){
        
// INIT INFOVIEW RECT
        InfoView.frame = CGRect(x: 0, y: -((view.bounds.height/4) * 1.5 + 40), width: view.bounds.width, height: (view.bounds.height/4) * 1.5)
        InfoView.layer.masksToBounds = false
        InfoView.layer.shadowColor = UIColor.black.cgColor
        InfoView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        InfoView.layer.shadowRadius = 3
        InfoView.layer.shadowOpacity = 0.8
           
        
// INIT HEADERVIEW RECT
        HeaderView.frame = CGRect(x:-3, y:0, width: InfoView.bounds.width + 6, height: view.bounds.height / 8)
        
// INIT LABELVIEW AND COSMOSVIEW
            LabelTitle.frame = CGRect(x:20, y:HeaderView.bounds.maxY - (LabelTitle.bounds.height + 10), width: HeaderView.bounds.width/2, height: 50)
                CosmosView.frame = CGRect(x: (HeaderView.bounds.maxX - (CosmosView.bounds.width + 20)), y: HeaderView.bounds.maxY - (LabelTitle.bounds.height/2 + CosmosView.bounds.height/2 + 10)   , width: HeaderView.bounds.width/2, height: 50)
             HeaderView.addSubview(CosmosView)
        HeaderView.addSubview(LabelTitle)
        InfoView.addSubview(HeaderView)
        
// HEADERVIEW properties
        HeaderView.layer.borderColor = UIColor.white.cgColor
        HeaderView.backgroundColor = UIColor.black
        HeaderView.layer.borderWidth = 1
        HeaderView.layer.shadowColor = UIColor.black.cgColor
        HeaderView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        HeaderView.layer.shadowRadius = 3
        HeaderView.layer.shadowOpacity = 0.5
         HeaderView.layer.backgroundColor =  lightpink
        view.addSubview(InfoView)
        
// INIT BOTTOM COSMOS
        bottom.frame = CGRect(x:0, y:view.bounds.height + 120, width: view.bounds.width, height: view.bounds.height)
          view.addSubview(bottom)
       
        BottomCosmos.frame = CGRect(x:0, y:0, width: view.bounds.width, height: view.bounds.height/10)
        bottom.addSubview(BottomCosmos)
        BottomCosmos.layer.masksToBounds = false
        BottomCosmos.layer.shadowColor = UIColor.black.cgColor
        BottomCosmos.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        BottomCosmos.layer.shadowRadius = 3
        BottomCosmos
            .layer.shadowOpacity = 0.8
         BottomCosmos.layer.backgroundColor =  lightpink
        bottomDetailsLabel.frame = CGRect(x: BottomCosmos.bounds.width / 2 - 100, y: -10, width: 200, height: BottomCosmos.bounds.height)
        BottomCosmos.addSubview(bottomDetailsLabel)
        initMainInfoV()
// INIT INFOBTNVIEW
        InfoBTNView.frame = CGRect(x:InfoView.bounds.maxX - 60,y:InfoView.bounds.maxY-25, width: 50, height: 50)
       // InfoBTNView.layer.masksToBounds = false
        self.InfoBTNView.layer.cornerRadius = self.InfoBTNView.bounds.width / 2
        InfoBTNView.layer.shadowColor = UIColor.black.cgColor
        InfoBTNView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        InfoBTNView.layer.shadowRadius = 3
        InfoBTNView.layer.shadowOpacity = 0.5
      //  InfoBTNView.layer.borderColor = UIColor.white.cgColor
    //    InfoBTNView.layer.borderWidth = 3
        InfoView.addSubview(InfoBTNView)
      
        
  // INIT PLACEIMG
        placeimgVIew.frame = CGRect(x: BottomCosmos.bounds.maxX - 110 ,y: BottomCosmos.bounds.minY - 110 , width:80 , height: 80)
        placeimgV.frame = CGRect(x: 0 ,y: 0 , width:80 , height: 80)
        PlaceImgVBtn.frame = CGRect(x: 0 ,y: 0 , width:80 , height: 80)
        placeimgVIew.layer.borderWidth = 2
        placeimgVIew.layer.borderColor = UIColor.white.cgColor
        placeimgVIew.layer.shadowColor = UIColor.black.cgColor
        placeimgVIew.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        placeimgVIew.layer.shadowRadius = 3
       placeimgVIew.layer.shadowOpacity = 0.5
        BottomCosmos.addSubview(placeimgVIew)
        placeimgVIew.addSubview(placeimgV)
       placeimgVIew.addSubview(PlaceImgVBtn)
       CosmosView.sizeToFit()
        self.LabelTitle.adjustsFontSizeToFitWidth = true
        self.LabelTitle.minimumScaleFactor = 0.2
        self.LabelTitle.numberOfLines = 0
        
// INIT callview
        
        CallView.frame = CGRect(x:InfoView.bounds.maxX - 120, y:InfoView.bounds.maxY-25, width: 50, height: 50)
        CallView.layer.masksToBounds = false
        CallView.layer.cornerRadius = CallView.bounds.width / 2
        CallView.layer.shadowColor = UIColor.black.cgColor
        CallView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        CallView.layer.shadowRadius = 3
        CallView.layer.shadowOpacity = 0.5
        CallView.layer.backgroundColor = self.darkblue
        InfoView.addSubview(CallView)
        InfoBTNView.layer.backgroundColor = self.darkblue
         RouteView.layer.backgroundColor = self.darkblue
         FavoriteV.layer.backgroundColor = self.pink.cgColor
        photocall.image = photocall.image?.withRenderingMode(.alwaysTemplate)
        photoInfo.image = photoInfo.image?.withRenderingMode(.alwaysTemplate)
        photoRoute.image = photoRoute.image?.withRenderingMode(.alwaysTemplate)
        FavoriteImg.image = FavoriteImg.image?.withRenderingMode(.alwaysTemplate)
        photocall.tintColor = pink
        photoInfo.tintColor = pink
        photoRoute.tintColor = pink
        FavoriteImg.tintColor = pink
        
        
    //    CallView.layer.borderWidth = 2
    //    CallView.layer.borderColor =  UIColor(red: 255 * 0.173 / 255.0, green: 255 * 0.243 / 255.0, blue: 255 * 0.314 / 255.0, alpha: 1.0).cgColor
        
   // INIT ROUTEVIEW
        RouteView.frame = CGRect(x:InfoView.bounds.maxX - 180, y:InfoView.bounds.maxY-25, width: 50, height: 50)
        RouteView.layer.masksToBounds = false
        RouteView.layer.cornerRadius = RouteView.bounds.width / 2
        RouteView.layer.shadowColor = UIColor.black.cgColor
        RouteView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        RouteView.layer.shadowRadius = 3
        RouteView.layer.shadowOpacity = 0.5
        InfoView.addSubview(RouteView)
        FavoriteV.frame = CGRect(x: InfoView.bounds.maxX-340,y:InfoView.bounds.maxY-25,width:150,height:50)
        FavoriteV.layer.cornerRadius = FavoriteV.bounds.height / 2
        
        InfoView.addSubview(FavoriteV)
        
       FavoriteImg.frame = CGRect(x:FavoriteV.bounds.width - 30,y:15,width:20,height:20)
        FavoritedeleteBTN.frame = CGRect(x:FavoriteV.bounds.width - 50,y:0,width:50,height:50)
        
        FavoriteV.addSubview(FavoriteImg)
        FavoriteV.addSubview(FavoritedeleteBTN)
        
        
    }
    
    
    func initblurinfo(){
        let mask = UIView(frame: blurinfo.bounds)
          mask.clipsToBounds = true
        mask.backgroundColor = UIColor.clear
      
        let outerbezierPath = UIBezierPath.init(roundedRect: blurinfo.bounds, cornerRadius: 0)
         let rect = CGRect(x:(blurinfo.bounds.width/2)-40, y:(blurinfo.bounds.height/2)-30, width : 80, height : 80)
        let innerCircle = UIBezierPath.init(roundedRect: rect, cornerRadius: rect.height/2)
        outerbezierPath.append(innerCircle)
        outerbezierPath.usesEvenOddFillRule = true
        let filllayer = CAShapeLayer()
        filllayer.fillRule = .evenOdd
        filllayer.fillColor = UIColor.green.cgColor
        filllayer.path = outerbezierPath.cgPath
        mask.layer.addSublayer(filllayer)
        blurinfo.mask = mask
        
    }
 
    @IBAction func routebtnclicked(_ sender: Any) {
        if(UIApplication.shared.canOpenURL(URL(string:"https://www.google.com/maps")!)){
            UIApplication.shared.open(NSURL(string: "comgooglemaps://?saddr=&daddr=\(Float(selectedann.selectedAnno.coordinate.latitude)),\(Float(selectedann.selectedAnno.coordinate.longitude))&directionsmode=driving")! as URL )}
        else {
             NSLog("Can't use Google maps.")
            }
        }
    
    @IBAction func callbtnclicked(_ sender: Any) {
        let result = selectedann.selectedAnno.Pne.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        guard let number = URL(string: "tel://" + result) else { return }
        UIApplication.shared.open(number)
    }
    
    
    func mapView(_ mapView: MGLMapView, didSelect annotationView: MGLAnnotationView) {
       
        if !(annotationView is MGLUserLocation) {
            
        self.filterbtn.isHidden = true
        incenter = false
        if let castAnno = annotationView.annotation as? CustomAnno {
               selectedann.selectedAnno = castAnno
            Firestore.firestore().collection("Base").document(castAnno.id).getDocument() { (document, error) in
                 self.addChild(self.child)
                self.child.view.frame = self.view.frame
                self.view.addSubview(self.child.view)
                self.child.didMove(toParent: self)
            SwipedUpViewController.selectedanno.anno = castAnno
           let vc = (self.storyboard!.instantiateViewController(withIdentifier: "SwipedUpViewController") as? SwipedUpViewController)!
                vc.view.frame = self.v1.bounds
                self.v1.addSubview(vc.view)
                let adr = document!.get("Address") as! String
                let Pne = document!.get("Phone") as! String
                let desc = document!.get("offer") as! String
                let pic = document!.get("picture") as! String
                let site = document!.get("website") as! String
                  selectedann.selectedAnno.adr = adr
                  selectedann.selectedAnno.Pne = Pne
                 selectedann.selectedAnno.pic = pic
                  selectedann.selectedAnno.site = site
                  selectedann.selectedAnno.desc = desc
           vc.descinit(S: selectedann.selectedAnno.desc)
            
                self.FavoriteV.frame = CGRect(x: self.InfoView.bounds.maxX-340,y:self.InfoView.bounds.maxY-25,width:150,height:50)
                self.InfoView.addSubview(self.FavoriteV)
                self.FavoriteImg.frame = CGRect(x:self.FavoriteV.bounds.width - 30,y:15,width:20,height:20)
            self.FavoritedeleteBTN.isHidden = true
            self.FavoriteaddBTN.isHidden = false
            self.Favlabel.isHidden = false
             self.FavoriteImg.image = UIImage(named: "plus")
            self.FavoriteV.addSubview(self.FavoriteImg)
            self.FavoriteV.addSubview(self.FavoritedeleteBTN)
            self.FavoriteV.layer.backgroundColor = self.pink.cgColor
            self.FavoriteImg.image = self.FavoriteImg.image?.withRenderingMode(.alwaysTemplate)
            self.FavoriteImg.tintColor = UIColor.white
            
            if let prevUser = Auth.auth().currentUser { Firestore.firestore().collection("user").document(prevUser.uid).collection("Favorites").getDocuments() { (document, error) in
  if error != nil {
                        print("error getting Favorites")} else {
                        for doc in document!.documents {
                            let id = doc.get("id") as! String
                            
                            if id == selectedann.selectedAnno.id {
                                self.Favlabel.isHidden = true
                                self.FavoritedeleteBTN.isHidden = false
                                self.FavoriteImg.image = UIImage(named: "check")
                                self.FavoriteImg.image = self.FavoriteImg.image?.withRenderingMode(.alwaysTemplate)
                                self.FavoriteImg.tintColor = UIColor.white
                                self.FavoriteaddBTN.isHidden = true
                                self.FavoriteV.backgroundColor = self.pink
                                self.FavoriteV.frame = self.FavoriteV.frame.offsetBy(dx: 50, dy: 0)
                                self.FavoriteV.frame = self.FavoriteV.frame.insetBy(dx: 50, dy: 0)
                                self.FavoriteImg.frame = CGRect(x:self.FavoriteV.bounds.width - 35,y:15,width:20,height:20)
                                self.FavoriteV.addSubview(self.FavoriteImg)
                                print(self.FavoriteV.bounds.width)
                            }
                        }}}
                self.infoup = true
            }
                self.child.willMove(toParent: nil)
                self.child.view.removeFromSuperview()
                self.child.removeFromParent()

            self.LabelTitle.text = selectedann.selectedAnno.title
            self.bottomDetailsLabel.text = self.VF.starting(times: selectedann.selectedAnno.startH, timee: selectedann.selectedAnno.endH, active: true)

            
                self.initAnno(A:selectedann.selectedAnno)
            self.placeimgV.image = selectedann.selectedAnno.image
                self.LabelType.text = "Signature : \(selectedann.selectedAnno.highlights)"
            
            var st = "+1"
            let result = selectedann.selectedAnno.Pne.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
            st = st + result
            
     
          

            }
        UIView.animate(withDuration: 1.0, animations: {
            mapView.setCenter((annotationView.annotation?.coordinate)!, zoomLevel: 15, animated: true)}, completion: {_ in
            self.blurinfo.isHidden = false} )
        UIView.animate(withDuration: 1.0, animations: {
            self.InfoView.frame =  self.InfoView.frame.offsetBy(dx: 0, dy: ((self.view.bounds.height/4) * 1.5 + 40))
            self.bottom.frame =  self.bottom.frame.offsetBy(dx: 0, dy: -(self.view.bounds.height/10 + 120))
           
            
        })
           
            }
            }
        
        
    }
   
    
    func mapView(_ mapView: MGLMapView, didDeselect annotation: MGLAnnotation) {
         if !(annotation is MGLUserLocation) {
            infoup = false
         blurinfo.isHidden = true
        UIView.animate(withDuration: 1.0, animations: {
           
            self.InfoView.frame =  self.InfoView.frame.offsetBy(dx: 0, dy: -((self.view.bounds.height/4) * 1.5 + 40))
                self.bottom.frame =  self.bottom.frame.offsetBy(dx: 0, dy: (self.view.bounds.height/10 + 120))
            
        })}
        filterbtn.isHidden = false
    }
 
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
 
    }
    func initcompass(){
        self.mapView.compassView.isHidden = true
       
    }
    @objc func diddragmap(gestureRecognizer: UIGestureRecognizer) {
        incenter = false
        locationview.isHidden = false
        if searchbardragged == false {
            
        
        UIView.animate(withDuration: 0.4, animations: {
            self.searchBarBlur.frame = self.searchBarBlur.frame.offsetBy(dx: 0, dy: -500)
            })
            searchbardragged = true
        }
    
    }
   
    @IBAction func btnlocation(_ sender: UIButton) {
      
        region = false
        let center = CLLocationCoordinate2D(latitude: (lastlocation?.latitude)!, longitude: (lastlocation?.longitude)!)
     
        mapView.setCenter(center, zoomLevel: 15, animated: true)
        if searchbardragged == true {
        UIView.animate(withDuration: 0.4, animations: {
            self.searchBarBlur.frame = self.searchBarBlur.frame.offsetBy(dx: 0, dy: 500)
        })
            searchbardragged = false
        }
        
        locationview.isHidden = true
    }
    
    func initlocationV(){
        locationview.layer.cornerRadius = locationview.bounds.width / 2
        locationview.layer.masksToBounds = false
        locationview.layer.shadowColor = UIColor.black.cgColor
        locationview.layer.borderColor = UIColor.black.cgColor
        locationview.layer.borderWidth = 0.5
        locationview.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        locationview.layer.shadowRadius = 1.0
        locationview.layer.shadowOpacity = 0.5
       // locationview.layer.borderColor = UIColor.black.cgColor
    //    locationview.layer.borderWidth = 0.5
        locationVimg.image = locationVimg.image?.withRenderingMode(.alwaysTemplate)
        locationVimg.tintColor = UIColor.black
    }
        
    func initframe () {
        
        let maskLayer = CAGradientLayer()
        maskLayer.frame = self.view.bounds
        maskLayer.colors = [ UIColor.clear.cgColor, UIColor.black.cgColor]
        maskLayer.locations = [0, 0.07]
        maskLayer.shadowRadius = 0.01
        maskLayer.shadowOpacity = 8
        maskLayer.shadowColor = UIColor.white.cgColor
        self.view.layer.mask = maskLayer
        gradientLayer()
    }
    

    func autolayout(){
        maskLayer1.frame = filterbtn.bounds
    }
    
    func locationInit(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
      //  locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }
    func searchbarinit(){
        searchBarBlur.layer.cornerRadius = 20
       SearchBarView.layer.masksToBounds = false
        SearchBarView.layer.borderColor = UIColor.white.cgColor
        searchBarBlur.layer.borderWidth = 0.8
        searchBarBlur.layer.masksToBounds = true
        SearchBarView.layer.shadowColor = UIColor.gray.cgColor
        SearchBarView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        SearchBarView.layer.shadowRadius = 10
        SearchBarView.layer.shadowOpacity = 0.5
        searchBarBlur.layer.borderColor = UIColor.white.cgColor
 
        
    }
  

    func gradientLayer(){
        let colortop = UIColor( red: 255.0/255.0, green: 212.0/255.0, blue: 175.0/255.0, alpha: 1.0).cgColor
        let colorbottom = UIColor(red: 255.0/255.0, green: 164.0/255.0, blue: 68.0/255.0, alpha: 1.0).cgColor
        maskLayer1.frame = filterbtn.bounds
        maskLayer1.colors = [ colortop, colorbottom]
        maskLayer1.locations = [0.0, 1.0]
        self.filterbtn.layer.insertSublayer(maskLayer1, at: 0)
        if let sublayers = filterbtn.layer.sublayers{
            for layer in sublayers{
                layer.cornerRadius = filterbtn.bounds.width / 2
}}
        autolayout()
    }
    
    func btninit(filterb: UIView){
        filterb.layer.cornerRadius = filterbtn.bounds.width / 2
        filterb.layer.masksToBounds = false
        filterb.layer.shadowColor = UIColor.black.cgColor
        filterb.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        filterb.layer.shadowRadius = 3
        filterb.layer.shadowOpacity = 0.8
        filterb.layer.borderColor = UIColor.white.cgColor
        filterb.layer.borderWidth = 4
      //  filterimg.image = filterimg.image?.withRenderingMode(.alwaysTemplate)
           // filterimg.tintColor = UIColor.white
        gradientLayer()
 
        }

    @IBAction func verifaddyesbtn(_ sender: Any) {
       UIView.animate(withDuration: 0.5, animations: {
            self.verifaddView.frame = self.verifaddView.frame.offsetBy(dx: 0, dy: 200)
        
        self.blurverif.isHidden = true
        })
     
        addfavoritelistener()
    }
    
    @IBAction func verifaddnobtn(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.verifaddView.frame = self.verifaddView.frame.offsetBy(dx: 0, dy: 200)
            self.blurverif.isHidden = true
        })
    }
    func initViewT(){
        verifaddView.frame = CGRect(x:0,y:view.bounds.height,width:view.bounds.width,height:200)
        view.addSubview(verifaddView)
    }
    
    
    
    
    @IBAction func filterbutton(_ sender: Any) {
         self.autolayout()
        if blurfilter.isHidden == true {
           UIView.animate(withDuration: 0.2, animations: {
            self.blurfilter.isHidden = false
                self.filterbtn.frame = self.filterbtn.frame.insetBy(dx: -10, dy: -10)
            self.btninit(filterb: self.filterbtn)
                self.filterbtn.frame =     self.filterbtn.frame.offsetBy(dx: -(self.view.bounds.width/2 - 50), dy:-(self.view.bounds.height/2 - 100) )
              }, completion: {_ in
                self.filterbtn.layer.layoutSublayers()
                self.addfilterestaurant(name: self.filtrestaurant)
                self.addfilterbar(name: self.filterbar)
           //     self.addfilterclothing(name: self.filterclothing)
                UIView.animate(withDuration: 0.2, animations: {
                    self.filtrestaurant.frame =     self.filtrestaurant.frame.offsetBy(dx: ( self.filterbtn.bounds.width+20), dy:0)
                     self.filterbar.frame =     self.filterbar.frame.offsetBy(dx: -(self.filterbtn.bounds.width+20), dy:0)
                    self.filterclothing.frame =     self.filterclothing.frame.offsetBy(dx: 0, dy:-(self.filterbtn.bounds.height + 20))
                    self.initlabel(label: self.labelbar, name: "Bars")
                    self.labelbar.frame = CGRect(x: self.filterbar.frame.minX, y: (self.filterbar.frame.minY - 40), width: self.filterbar.bounds.width, height: 30)
                    self.initlabel(label: self.labelrestaurant, name: "Restaurants")
                    self.labelrestaurant.frame = CGRect(x: self.filtrestaurant.frame.minX, y: (self.filtrestaurant.frame.minY - 40), width: self.filtrestaurant.bounds.width, height: 30)
                    self.view.addSubview(self.labelbar)
                    self.view.insertSubview(self.labelbar, belowSubview: self.filterbtn)
                    self.view.addSubview(self.labelrestaurant)
                    self.view.insertSubview(self.labelrestaurant, belowSubview: self.filterbtn)
                    self.labelbar.isHidden = false
                    self.labelrestaurant.isHidden = false
                })})}
        else {
             DispatchQueue.main.async {
              UIView.animate(withDuration: 0.2, animations: {
                self.labelbar.isHidden = true
                self.labelrestaurant.isHidden = true
                self.filtrestaurant.frame =     self.filtrestaurant.frame.offsetBy(dx: -( self.filterbtn.bounds.width+20), dy:0)
                self.filterbar.frame =     self.filterbar.frame.offsetBy(dx: (self.filterbtn.bounds.width+20), dy:0)
                self.filterclothing.frame =     self.filterclothing.frame.offsetBy(dx: 0, dy:(self.filterbtn.bounds.height + 20))
              }, completion: {_ in
                self.filterclothing.isHidden = true
                self.filterbar.isHidden = true
                self.filtrestaurant.isHidden = true
                UIView.animate(withDuration: 0.2, animations: {
                    self.filterbtn.frame = self.filterbtn.frame.insetBy(dx: 10, dy: 10)
                    self.btninit(filterb: self.filterbtn)
                    self.filterbtn.frame =     self.filterbtn.frame.offsetBy(dx:(self.view.bounds.width/2 - 50 ), dy:(self.view.bounds.height/2 - 100  ))
                }, completion: {_ in
                    self.blurfilter.isHidden = true
                })})  } }}
    
    
    
    
    
    
    
    
 
    func initlabel(label: UILabel, name: String){
        label.text = name
        label.font = UIFont(name: "PingFang" , size: 10.0 )
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(red: 128.0/255.0, green: 127.0/255.0, blue: 127.0/255.0, alpha: 1.0)
       label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
    }
    
    
    
    
    
    @IBAction func searchbtnclicked(_ sender: UIButton) {
        let vc =
         
            UIViewController.instantiateWith(story: .MAIN, identifier: SearchbarViewController.storyboardIdentifier) as! SearchbarViewController
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
     //   vc.mapView = self.mapView
      //  vc.lastLocation = self.presenter.currentLocation
      //  vc.handleMapSearchDelegate = presenter
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        present(vc, animated: false, completion: nil)
    }
    
    
    
    
    func addfilterestaurant (name: UIView){
    self.filtrestaurant = UIView(frame: CGRect(x: self.filterbtn.frame.minX,y: self.filterbtn.frame.minY, width:self.filterbtn.bounds.width, height: self.filterbtn.bounds.height))
      //  name = Name
    self.filtrestaurant.backgroundColor = UIColor.white
    self.btninit(filterb: self.filtrestaurant)
   //name.isHidden = true
    self.view.addSubview(self.filtrestaurant)
         self.view.insertSubview(self.filtrestaurant, belowSubview: filterbtn)
        let imgres = "burgerCartoon.png"
            let img = UIImage(named: imgres)
        let imagv = UIImageView(image: img)
        imagv.frame = self.filtrestaurant.bounds
        filtrestaurant.addSubview(imagv)
    }
    func addfilterbar (name: UIView){
      
       
        self.filterbar = UIView(frame: CGRect(x: self.filterbtn.frame.minX,y: self.filterbtn.frame.minY, width:self.filterbtn.bounds.width, height: self.filterbtn.bounds.height))
        //  name = Name
        self.filterbar.backgroundColor = UIColor.white
        self.btninit(filterb: self.filterbar)
        //name.isHidden = true
        self.view.addSubview(self.filterbar)
        self.view.insertSubview(self.filterbar, belowSubview: filterbtn)
        let imgres = "wineCup.png"
        let img = UIImage(named: imgres)
        let imagv = UIImageView(image: img)
        imagv.frame = CGRect(x: self.filterbar.bounds.midX - 25, y:self.filterbar.bounds.midY - 40, width: 50, height: 80)
        filterbar.addSubview(imagv)
    }

 //   func addfilterclothing (name: UIView){
   //     self.filterclothing = UIView(frame: CGRect(x: self.filterbtn.frame.minX,y: self.filterbtn.frame.minY, width:self.filterbtn.bounds.width, height: self.filterbtn.bounds.height))
        //  name = Name
    //    self.filterclothing.backgroundColor = UIColor.white
    //    self.btninit(filterb: self.filterclothing)
        //name.isHidden = true
    //self.view.addSubview(self.filterclothing)
     //   self.view.insertSubview(self.filterclothing, belowSubview: filterbtn)
//    }
     //   self.view.bringSubviewToFront(view1)
     //   let  label: UILabel = UILabel()
      //  label.text = name
      //  label.textColor = UIColor.black
      //  view1.addSubview(label)
 

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
       if (!(annotation is MGLUserLocation)) {
        let castAn = annotation as? CustomAnno
        let reuseId = " \(annotation.coordinate.longitude)"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if annotationView == nil {
            annotationView = MGLAnnotationView(reuseIdentifier: reuseId)
            annotationView!.bounds = CGRect(x:-20 , y:-20, width: 100, height: 80)
            var img = UIImage()
            if castAn?.Cat == "Burger" {
              img = UIImage(named: "BurgerBubbleV2")!
            }
            else if castAn?.Cat == "Beer"{
                img = UIImage(named: "BeerBubbleV3")!
            }
            else if castAn?.Cat == "wine"{
                img = UIImage(named: "WineBubbleV2")!
            }
            else if castAn?.Cat == "groceries"{
                img = UIImage(named: "BubbleGroceriesV2")!
            }
            else if castAn?.Cat == "clothes"{
                img = UIImage(named: "BubbleClothesV2")!
            }
            else if castAn?.Cat == "salad"{
                img = UIImage(named: "BubbleSaladV2")!
            }
            else if castAn?.Cat == "pasta"{
                img = UIImage(named: "BubblePastaV2")!
            }
            else if castAn?.Cat == "pizza"{
                img = UIImage(named: "BubblePizzaV2")!
            }
            else if castAn?.Cat == "sushi"{
                img = UIImage(named: "BubbleSushiV2")!
            }
            else if castAn?.Cat == "util"{
                img = UIImage(named: "BubbleUtilV2")!
            }
            else if castAn?.Cat == "club"{
                img = UIImage(named: "ClubBubbleV2")!
            }
            let imgv = UIImageView(image: img)
            imgv.layer.masksToBounds = false
            imgv.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
          //imgv.layer.shadowPath = shadowPath.cgPath
            if castAn!.active == true {
            imgv.layer.shadowColor =  UIColor( red: 0.0/255.0, green: 171.0/255.0, blue: 11.0/255.0, alpha: 1.0).cgColor        }
            else { imgv.layer.shadowColor = UIColor.black.cgColor}
            //( red: 255.0/255.0, green: 36.0/255.0, blue: 127.0/255.0, alpha: 1.0).cgColor}
            imgv.frame = CGRect(x:0 , y:0, width: 60, height: 60)
          
                    annotationView!.addSubview(imgv)
                    annotationView!.backgroundColor = UIColor.clear

            imgv.layer.shadowRadius = 5
            imgv.layer.shadowOpacity = 1
            
            
        }
        return annotationView
       }
       else {
      
        let annotationV = MGLUserLocationAnnotationView()
        annotationV.isEnabled = false
        annotationV.isDraggable = false
        annotationV.isSelected = false
        return annotationV
        }
       
    }
    

    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return false
    }
    
    func initAnno(A:CustomAnno){
       
        LabelAdr.text = A.adr
        var StringS : String =  A.startH
        var StringE : String =  A.endH
       StringS.insert(":", at: .init(encodedOffset: 2))
        StringE.insert(":", at:.init(encodedOffset: 2))
        LabelOffer.text = "Promotion Starts \(StringS)00 -> \(StringE)00 "
        LabelInfo.text = A.Pne
    }
    @IBAction func profileclicked(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            
            
            self.present(vprofile, animated: false, completion:  nil)
        }else {
            requireLogin()
        }
    }
    
    func initMainInfoV() {
        let part = (InfoView.bounds.height - HeaderView.bounds.height) / 6
        let specwidth = InfoView.bounds.width - 40
        let widthlabel = InfoView.bounds.width - 40
        let speclabelwidth = InfoView.bounds.width * 0.8
        self.LabelType.adjustsFontSizeToFitWidth = true
        self.LabelType.minimumScaleFactor = 0.2
        self.LabelType.numberOfLines = 0
        self.LabelType.lineBreakMode = NSLineBreakMode.byWordWrapping
        

        
        labelTypeView.frame = CGRect(x:20,y:HeaderView.bounds.height,width:widthlabel,height: part*2 )
        InfoView.addSubview(labelTypeView)
        LabelType.frame = CGRect(x:0,y:0,width:labelTypeView.bounds.width, height:labelTypeView.bounds.height)
        labelTypeView.addSubview(LabelType)
     
        let afterlabely =  (HeaderView.bounds.height + labelTypeView.bounds.height) - 6
        
        let viewM2 = UIView()
        viewM2.frame = CGRect(x:10,y:afterlabely,width:InfoView.bounds.width-20,height:1)
        InfoView.addSubview(viewM2)
        viewM2.backgroundColor = UIColor.lightGray
        
        ViewOffer.frame = CGRect(x:10,y:afterlabely,width:specwidth,height:part)
            LabelOffer.frame = CGRect(x:40,y:0,width:speclabelwidth,height:part)
            ViewOffer.addSubview(LabelOffer)
        InfoView.addSubview(ViewOffer)
      let viewM = UIView()
       viewM.frame = CGRect(x:10,y:afterlabely+part,width:InfoView.bounds.width-20,height:1)
        InfoView.addSubview(viewM)
        viewM.backgroundColor = UIColor.lightGray
        VIewAdr.frame = CGRect(x:10,y:afterlabely+part+5,width:specwidth,height:part)
            LabelAdr.frame = CGRect(x:40,y:0,width:speclabelwidth,height:part)
            VIewAdr.addSubview(LabelAdr)
        InfoView.addSubview(VIewAdr)
        let viewM1 = UIView()
        viewM1.frame = CGRect(x:10,y:afterlabely+(part*2+5),width:InfoView.bounds.width-20,height:1)
        viewM1.backgroundColor = UIColor.lightGray
        InfoView.addSubview(viewM1)
        ViewInfo.frame = CGRect(x:10,y:afterlabely+(part*2+10),width:specwidth,height:part-3)
            LabelInfo.frame = CGRect(x:40,y:0,width:speclabelwidth,height:part-3)
            ViewInfo.addSubview(LabelInfo)
        let viewM3 = UIView()
        viewM3.layer.borderWidth = 2
        viewM3.layer.borderColor = UIColor.white.cgColor
        
        viewM3.frame = CGRect(x: -2, y: afterlabely+(part*3+10), width: view.bounds.width+4, height: InfoView.bounds.height-(afterlabely+(part*3+10)))
        viewM3.layer.shadowColor = UIColor.white
            .cgColor
        viewM3.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        viewM3.layer.shadowRadius = 2
        viewM3.layer.shadowOpacity = 1
      
        InfoView.addSubview(viewM3)
        InfoView.addSubview(ViewInfo)

    }
    @IBAction func favdelclicked(_ sender: Any) {
        if let prevUser = Auth.auth().currentUser {
            Firestore.firestore().collection("user").document(prevUser.uid).collection("Favorites").whereField("id", isEqualTo: selectedann.selectedAnno.id).getDocuments() {(query, err) in
                if let err = err {
                    print("error")
                } else {
                    for doc in query!.documents {
                        doc.reference.delete()
                        UIView.animate(withDuration: 0.5, animations: {
                            self.FavoriteV.frame = self.FavoriteV.frame.offsetBy(dx: -50, dy: 0)
                            self.FavoriteV.frame = self.FavoriteV.frame.insetBy(dx: -50, dy: 0)
                            self.FavoriteImg.image = UIImage(named: "plus")
                            self.FavoriteImg.image = self.FavoriteImg.image?.withRenderingMode(.alwaysTemplate)
                            self.FavoriteImg.tintColor = UIColor.white
                        }, completion: {_ in
                            self.Favlabel.isHidden = false
                            self.FavoriteaddBTN.isHidden = false
                            self.FavoritedeleteBTN.isHidden = true
                            self.FavoriteV.layer.backgroundColor = self.pink.cgColor
                            self.FavoriteImg.frame = CGRect(x:self.FavoriteV.bounds.width - 30,y:15,width:20,height:20)
                            self.FavoriteV.addSubview(self.FavoriteImg)
                            print(self.FavoriteV.bounds.width)
                        })
                       
                    }
                }
                
            }
            
        }
        
    }
    @IBAction func favoriteClick(_ sender: Any) {
        if let prevUser = Auth.auth().currentUser {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.verifaddView.frame = self.verifaddView.frame.offsetBy(dx: 0, dy: -200)
                  self.view.bringSubviewToFront(self.blurverif)
                self.view.bringSubviewToFront(self.verifaddView)
                self.blurverif.isHidden = false
            })
            
        }
        else {
       requireLogin()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func addfavoritelistener(){
        let prevUser = Auth.auth().currentUser
        Firestore.firestore().collection("user").document(prevUser!.uid).collection("Favorites").addDocument(data: ["id": selectedann.selectedAnno.id]){ err in
            
            if let err = err {
                print("error")
            } else {
                self.Favlabel.isHidden = true
                self.FavoritedeleteBTN.isHidden = false
                UIView.animate(withDuration: 0.5, animations: {
                    self.FavoriteV.frame = self.FavoriteV.frame.offsetBy(dx: 50, dy: 0)
                    self.FavoriteV.frame = self.FavoriteV.frame.insetBy(dx: 50, dy: 0)
                    self.FavoriteImg.image = UIImage(named: "check")
                    self.FavoriteImg.image = self.FavoriteImg.image?.withRenderingMode(.alwaysTemplate)
                    self.FavoriteImg.tintColor = UIColor.white
                }, completion: {_ in
                    self.FavoriteaddBTN.isHidden = true
                    self.FavoriteV.layer.backgroundColor = self.pink.cgColor
                    
                    self.FavoriteImg.frame = CGRect(x:self.FavoriteV.bounds.width - 35,y:15,width:20,height:20)
                    self.FavoriteV.addSubview(self.FavoriteImg)
                    print(self.FavoriteV.bounds.width)
                })
            }
            
        }
        
    }
    
    
func requireLogin(){
    let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
    self.present(vc!, animated: true, completion: nil)
}
    
        func profileinit(){
        profileV.frame = CGRect(x: view.bounds.width - 60,y:40,width:40,height:40)
        profileV.layer.cornerRadius = 20
        profileV.layer.shadowColor = UIColor.black.cgColor
        profileV.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        profileV.layer.shadowRadius = 10
        profileV.layer.shadowOpacity = 1
        profileimg.layer.cornerRadius = 20
       
        profileimg.image = UIImage(named: "profile")
        self.profileimg.clipsToBounds = true
        self.profileimg.layer.masksToBounds = true
        view.addSubview(profileV)
        
    }
}




extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lastlocation = location.coordinate
           
                    if incenter == false  {
                                            }else {
                        locationview.isHidden = true
                        
                       
                        
                        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                        self.mapView.setCenter(center, zoomLevel: 14, animated: true)
                        
                        self.mapView.showsUserLocation = true
                    
                    }
            }
        
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        } 
    
}
class customAnnotationView: MGLAnnotationView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.duration = 0.1
        layer.borderWidth = selected ? bounds.width / 4 : 2
        layer.add(animation, forKey: "borderWidth")
    }
}


 





