class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(App.bounds)
    @window.makeKeyAndVisible

    @controller = CurvePlotController.alloc.initWithNibName("CurvePlotController", bundle:nil)
    @window.rootViewController = @controller

    true
  end

  # attr_accessor :viewController, :window

  # def application(application, didFinishLaunchingWithOptions:launchOptions)

  #   self.window.rootViewController = self.viewController
  #   self.window.makeKeyAndVisible

  #   true
  # end
end
