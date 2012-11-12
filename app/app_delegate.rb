class AppDelegate

  attr_accessor :viewController, :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)

    self.window.rootViewController = self.viewController
    self.window.makeKeyAndVisible

    true
  end
end
