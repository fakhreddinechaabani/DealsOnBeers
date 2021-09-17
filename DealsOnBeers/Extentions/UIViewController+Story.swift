

import UIKit

extension UIStoryboard {
    static func getStoryboard(_ story: Storyboards) -> UIStoryboard {
        return UIStoryboard(name: story.description, bundle: nil)
    }
}

