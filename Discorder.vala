/* MIT License
#
# Copyright (c) 2020 Ferhat Geçdoğan All Rights Reserved.
# Distributed under the terms of the MIT License.
#
# */

/* Use Gtk and Webkit namespaces */
using Gtk;
using WebKit;

public class Discorder : Window {
	/* Set Window title */
    private const string TITLE = "Discorder";
    
    /* Default URL */
    private const string DEFAULT_URL = "https://discord.com/app/";
    
    /* Default protocol */
    private const string DEFAULT_PROTOCOL = "http";

    private Regex protocol_regex;
    
    private WebView web_view;
    private ToolButton _discorder_button; /* As a home button */

	private HeaderBar headerBar;
	
	private WebContext webContext;
	private CookieManager cookieManager;
	
	private string cookie_data = GLib.Environment.get_home_dir();
	
	public Discorder() {
    	headerBar = new HeaderBar();

    	webContext = new WebContext();

        headerBar.set_title (Discorder.TITLE);
		headerBar.set_subtitle ("\'Discording\' for everyone, everytime.");
        headerBar.set_show_close_button (true);
		

       this.set_default_size(800, 600);
    
        
        try {
            this.protocol_regex = new Regex(".*://.*");
        } catch (RegexError e) {
            critical("%s", e.message);
        }
		
        create_widgets();
        connect_signals();
  
    }

    private void create_widgets() {
        Gtk.Image img = new Gtk.Image.from_file("/usr/share/pixmaps/discorder/discorder_32.png");
		this._discorder_button = new Gtk.ToolButton(img, null);
        
        
		headerBar.pack_start(this._discorder_button);

        
        this.set_titlebar(headerBar);
 

    	cookieManager = webContext.get_cookie_manager();
    	cookieManager.set_persistent_storage(this.cookie_data, CookiePersistentStorage.TEXT);
    	web_view = new WebView.with_context(webContext);
    	
    	print("Data: " + this.cookie_data);
        
        var scrolled_window = new ScrolledWindow(null, null);
        
        scrolled_window.set_policy(PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        scrolled_window.add(this.web_view);
        

        var box = new Box(Gtk.Orientation.VERTICAL, 0);
        box.pack_start(scrolled_window, true, true, 0);
        add(box);
    }

    private void connect_signals() {
        this.destroy.connect(Gtk.main_quit);
        
        this._discorder_button.clicked.connect(discorder_button);
    }

	private void discorder_button() {
		this.web_view.load_uri(DEFAULT_URL);
	}

    public void start() {
        show_all();
        this.web_view.load_uri(DEFAULT_URL);
    }

    public static int main(string[] args) {
        Gtk.init(ref args);

        var browser = new Discorder();
        browser.start();

        Gtk.main();

        return 0;
    }
}
