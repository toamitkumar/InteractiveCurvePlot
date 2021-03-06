class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)

    define_nano_storage_option
    create_levers
    create_brands_and_associate_levers

    @window = UIWindow.alloc.initWithFrame(App.bounds)
    @window.makeKeyAndVisible

    @controller = CurvePlotController.alloc.initWithNibName("CurvePlotController", bundle:nil)
    @window.rootViewController = @controller

    true
  end

  def define_nano_storage_option
    NanoStore.shared_store = NanoStore.store(:memory)
  end

  def create_levers
    @lever_names = ["TV", "Umbrella TV", "OOH", "Display", "Facebook", "Umbrella Viral FB", "Positive Social GRP"]
  end

  def create_brands_and_associate_levers
    @brands = [Brand.create(:name => "Brand A", :description => "Brand Alpha")]

    brand = @brands[0]

    brand.levers << Lever.create(:name => @lever_names[0], :color => "A2AD01")
    brand.levers << Lever.create(:name => @lever_names[1], :color => "E47C33")
    brand.levers << Lever.create(:name => @lever_names[2], :color => "CF2A35")
    brand.levers << Lever.create(:name => @lever_names[3], :color => "006600")
    brand.levers << Lever.create(:name => @lever_names[4], :color => "370066")
    brand.levers << Lever.create(:name => @lever_names[5], :color => "1EB4B8")
    brand.levers << Lever.create(:name => @lever_names[6], :color => "E47C33")
    # brand.levers << Lever.create(:name => @lever_names[7], :color => "1CA4EE")

  end

  # attr_accessor :viewController, :window

  # def application(application, didFinishLaunchingWithOptions:launchOptions)

  #   self.window.rootViewController = self.viewController
  #   self.window.makeKeyAndVisible

  #   true
  # end
end
