{
  flake.homeModules.mangowm = {
    wayland.windowManager.mango = {
      enable = true;
      settings = {
        # Window effect
        blur = 0;
        blur_layer = 0;
        blur_optimized = 1;
        blur_params = {
          num_passes  =  2;
          radius  =  5;
          noise  =  0.02;
          brightness  =  0.9;
          contrast  =  0.9;
          saturation  =  1.2;
        };

        shadows  =  0;
        layer_shadows  =  0;
        shadow_only_floating  =  1;
        shadows_size  =  10;
        shadows_blur  =  15;
        shadows_position_x  =  0;
        shadows_position_y  =  0;
        # shadowscolor =  0x000000ff;

        border_radius = 6;
        no_radius_when_single = 0;
        focused_opacity = 1.0;
        unfocused_opacity = 1.0;

        # Animation Configuration(support type:zoom,slide)
        # tag_animation_direction: 1-horizontal,0-vertical
        animations = 1;
        layer_animations = 1;
        animation_type_open = "slide";
        animation_type_close = "slide";
        animation_fade_in = 1;
        animation_fade_out = 1;
        tag_animation_direction = 1;
        zoom_initial_ratio = 0.4;
        zoom_end_ratio = 0.8;
        fadein_begin_opacity = 0.5;
        fadeout_begin_opacity = 0.8;
        animation_duration_move = 500;
        animation_duration_open = 400;
        animation_duration_tag = 350;
        animation_duration_close = 800;
        animation_duration_focus = 0;
        animation_curve_open = "0.46,1.0,0.29,1";
        animation_curve_move = "0.46,1.0,0.29,1";
        animation_curve_tag = "0.46,1.0,0.29,1";
        animation_curve_close = "0.08,0.92,0,1";
        animation_curve_focus = "0.46,1.0,0.29,1";
        animation_curve_opafadeout = "0.5,0.5,0.5,0.5";
        animation_curve_opafadein = "0.46,1.0,0.29,1";

        # Scroller Layout Settings
        scroller_structs = 20;
        scroller_default_proportion = 0.8;
        scroller_focus_center = 0;
        scroller_prefer_center = 0;
        edge_scroller_pointer_focus = 1;
        edge_scroller_focus_allow_speed = 0.0;
        scroller_default_proportion_single = 1.0;
        scroller_proportion_preset = 0.5,0.8,1.0;

        # Master-Stack Layout Setting
        new_is_master = 1;
        default_mfact = 0.55;
        default_nmaster = 1;
        tag_num = 9;
        smartgaps = 0;

        # Dwindle Layout Setting
        dwindle_smart_split = 0;
        dwindle_drop_simple_split = 1;
        dwindle_manual_split = 0;
        dwindle_hsplit = 1;
        dwindle_vsplit = 1;
        dwindle_preserve_split = 0;

        # Overview Setting
        hotarea_size = 10;
        enable_hotarea = 0;
        ov_tab_mode = 1;
        overviewgappi = 5;
        overviewgappo = 30;

        # Misc
        no_border_when_single = 0;
        axis_bind_apply_timeout = 100;
        focus_on_activate = 1;
        idleinhibit_ignore_visible = 0;
        sloppyfocus = 1;
        warpcursor = 1;
        focus_cross_monitor = 0;
        focus_cross_tag = 0;
        enable_floating_snap = 0;
        snap_distance = 30;
        cursor_size = 24;
        drag_tile_to_tile = 1;
        drag_tile_small = 1;

        # keyboard
        repeat_rate = 25;
        repeat_delay = 600;
        numlockon = 0;
        xkb_rules_layout = "us";

        # Trackpad
        # need relogin to make it apply
        disable_trackpad = 0;
        tap_to_click = 1;
        tap_and_drag = 1;
        drag_lock = 1;
        trackpad_natural_scrolling = 0;
        disable_while_typing = 1;
        left_handed = 0;
        middle_button_emulation = 0;
        swipe_min_threshold = 1;

        # mouse
        # need relogin to make it apply;
        mouse_natural_scrolling = 0;

        # Appearance
        gappih = 5;
        gappiv = 5;
        gappoh = 10;
        gappov = 10;
        scratchpad_width_ratio = 0.8;
        scratchpad_height_ratio = 0.9;
        borderpx = 4;
        # rootcolor = 0x201b14ff;
        # bordercolor = 0x444444ff;
        # dropcolor = 0x8FBA7C55;
        # splitcolor = 0xEB441EFF;
        # focuscolor = 0xc9b890ff;
        # maximizescreencolor = 0x89aa61ff;
        # urgentcolor = 0xad401fff;
        # scratchpadcolor = 0x516c93ff;
        # globalcolor = 0xb153a7ff;
        # overlaycolor = 0x14a57cff;

        # layout support:
        # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
        tagrule = [
          "id:1,layout_name:tile"
          "id:2,layout_name:tile"
          "id:3,layout_name:tile"
          "id:4,layout_name:tile"
          "id:5,layout_name:tile"
          "id:6,layout_name:tile"
          "id:7,layout_name:tile"
          "id:8,layout_name:tile"
          "id:9,layout_name:tile"
        ];

        # key bindings
        # key name refer to `xev` or `wev` command output,;
        # mod keys name: super,ctrl,alt,shift,none;
        
        bind = [
          # reload config
          "super,r,reload_config"

          # menu and terminal
          "alt,space,spawn,rofi -show drun"
          "alt,return,spawn,foot"

          # exit
          "super,m,quit"
          "alt,q,killclient"

          # switch window focus
          "super,tab,focusstack,next"
          "alt,left,focusdir,left"
          "alt,right,focusdir,right"
          "alt,up,focusdir,up"
          "alt,down,focusdir,down"

          # swap window
          "super+shift,up,exchange_client,up"
          "super+shift,down,exchange_client,down"
          "super+shift,left,exchange_client,left"
          "super+shift,right,exchange_client,right"

          # switch window status
          "super,g,toggleglobal,"
          "alt,tab,togglejump,"
          "alt,backslash,togglefloating,"
          "alt,a,togglemaximizescreen,"
          "alt,f,togglefullscreen,"
          "alt+shift,f,togglefakefullscreen,"
          "super,i,minimized,"
          "super,o,toggleoverlay,"
          "super+shift,i,restore_minimized"
          "alt,z,toggle_scratchpad"

          # scroller layout
          "alt,e,set_proportion,1.0"
          "alt,x,switch_proportion_preset,"
          "alt+super+ctrl,left,scroller_stack,left"
          "alt+super+ctrl,right,scroller_stack,right"
          "alt+super+ctrl,up,scroller_stack,up"
          "alt+super+ctrl,down,scroller_stack,down"

          #dwindle layout(manual split mode)
          "alt+shift,return,dwindle_toggle_split_direction"

          # switch layout
          "super,n,switch_layout"

          # tag switch
          "super,left,viewtoleft,0"
          "ctrl,left,viewtoleft_have_client,0"
          "super,right,viewtoright,0"
          "ctrl,right,viewtoright_have_client,0"
          "ctrl+super,left,tagtoleft,0"
          "ctrl+super,right,tagtoright,0"

          "ctrl,1,view,1,0"
          "ctrl,2,view,2,0"
          "ctrl,3,view,3,0"
          "ctrl,4,view,4,0"
          "ctrl,5,view,5,0"
          "ctrl,6,view,6,0"
          "ctrl,7,view,7,0"
          "ctrl,8,view,8,0"
          "ctrl,9,view,9,0"

          # tag: move client to the tag and focus it
          # tagsilent: move client to the tag and not focus it
          # alt,1,tagsilent,1
          "alt,1,tag,1,0"
          "alt,2,tag,2,0"
          "alt,3,tag,3,0"
          "alt,4,tag,4,0"
          "alt,5,tag,5,0"
          "alt,6,tag,6,0"
          "alt,7,tag,7,0"
          "alt,8,tag,8,0"
          "alt,9,tag,9,0"

          # monitor switch
          "alt+shift,left,focusmon,left"
          "alt+shift,right,focusmon,right"
          "super+alt,left,tagmon,left"
          "super+alt,right,tagmon,right"

          # gaps
          "alt+shift,x,incgaps,1"
          "alt+shift,z,incgaps,-1"
          "alt+shift,r,togglegaps"

          # movewin
          "ctrl+shift,up,movewin,+0,-50"
          "ctrl+shift,down,movewin,+0,+50"
          "ctrl+shift,left,movewin,-50,+0"
          "ctrl+shift,right,movewin,+50,+0"

          # resizewin
          "ctrl+alt,up,resizewin,+0,-50"
          "ctrl+alt,down,resizewin,+0,+50"
          "ctrl+alt,left,resizewin,-50,+0"
          "ctrl+alt,right,resizewin,+50,+0"
        ];

        # mouse button bindings
        # btn_left and btn_right can't bind none mod key;
        mousebind = [
          "super,btn_left,moveresize,curmove"
          "none,btn_middle,togglemaximizescreen,0"
          "super,btn_right,moveresize,curresize"
        ];

        # axis bindings
        axisbind = [
          "super,up,viewtoleft_have_client"
          "super,down,viewtoright_have_client"
        ];

        # layer rule
        layerrule = [
          "animation_type_open:zoom,layer_name:rofi"
          "animation_type_close:zoom,layer_name:rofi"
        ];
      };
    };
  };
}
