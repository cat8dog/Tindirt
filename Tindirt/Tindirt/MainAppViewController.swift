import UIKit

class MainAppViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    

    
    // creating a variable to prepare for pushing to the next view in the stack
    var xFromCenter: CGFloat = 0
    var label: UILabel!
    var imageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // gesture recognizer
        imageView = UIImageView(frame: CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 50, 200, 200))
        // default image for our user
        imageView.image = UIImage(named:"Barfy Barbies.jpg")
        // add a corner radius to our image
        self.view.addSubview(imageView)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        var gesture = UIPanGestureRecognizer(target: self, action: Selector ("wasDragged:"))
        imageView.addGestureRecognizer(gesture)
        imageView.userInteractionEnabled = true

        // Do any additional setup after loading the view.
    }


func wasDragged(gesture:UIPanGestureRecognizer) {
    let translation = gesture.translationInView(self.view)
    // get was has been dragged
    var profile = gesture.view!
    xFromCenter += translation.x
    var scale = min(100 / abs(xFromCenter), 1)
    profile.center = CGPoint(x: profile.center.x + translation.x, y: profile.center.y + translation.y)
    // reset translation (back to default position)
    gesture.setTranslation(CGPointZero, inView: self.view)
    // rotate the label/image
    var rotation:CGAffineTransform = CGAffineTransformMakeRotation(translation.x / 200)
    // stretch the view
    var stretch:CGAffineTransform = CGAffineTransformScale(rotation, scale, scale)
    // stretch the image / label
    xFromCenter += translation.x
    // define whether or not someone is chosen
    if profile.center.x < 100 {
        println("not chosen")
    } else {
        println("chosen")
        // we could add chosen user to parse
    }
    
    // when the gesture state has ended
    if gesture.state == UIGestureRecognizerState.Ended {
        // set the label/image back
        profile.center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
        // undo scale
        scale = max(abs(xFromCenter) / 100, 1)
        // undo any rotations
        rotation = CGAffineTransformMakeRotation(0)
        //stretch the current view
        stretch = CGAffineTransformScale(rotation, scale, scale)
        // set the image or label to original size after scaling
        imageView.frame = CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 50, 200, 200)
    }
    
    
}

}


