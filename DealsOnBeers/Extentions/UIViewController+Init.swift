

import UIKit

extension UIViewController {
    static func instantiateWith(story: Storyboards, identifier: String) -> UIViewController {
        return UIStoryboard.getStoryboard(story).instantiateViewController(withIdentifier: identifier)
    }
}
