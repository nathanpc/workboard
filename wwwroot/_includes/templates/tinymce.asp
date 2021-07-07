<!-- tinyMCE -->
<script language="javascript" type="text/javascript" src="/assets/lib/tiny_mce/tiny_mce.js"></script>
<script language="javascript" type="text/javascript">
	tinyMCE.init({
		mode: "exact",
		elements: "tinymce",
		theme: "advanced",
		plugins: "style,layer,table,advimage,advlink,emotions,iespell,insertdatetime,searchreplace,contextmenu,paste,fullscreen,noneditable",
		theme_advanced_buttons1_add: "fontselect,fontsizeselect",
		theme_advanced_buttons2_add: "separator,insertdate,inserttime",
		theme_advanced_buttons2_add_before: "cut,copy,paste,pastetext,pasteword,separator,search,replace,separator",
		theme_advanced_buttons3_add_before: "tablecontrols,separator",
		theme_advanced_buttons3_add: "emotions,iespell,separator,forecolor,backcolor,styleprops,separator,fullscreen",
		theme_advanced_toolbar_location: "top",
		theme_advanced_toolbar_align: "left",
		theme_advanced_path_location: "bottom",
	    plugin_insertdate_dateFormat: "%Y-%m-%d",
	    plugin_insertdate_timeFormat: "%H:%M:%S",
		extended_valid_elements: "hr[class|width|size|noshade],font[face|size|color|style],span[class|align|style]",
		content_css: "/assets/css/default.css",
		theme_advanced_resize_horizontal: false,
		theme_advanced_resizing: true
	});
</script>
<!-- /tinyMCE -->