(function() {
  // Load plugin specific language pack
  tinymce.PluginManager.requireLangPack('somoslink');

  tinymce.create('tinymce.plugins.SomosLinkPlugin', {
    init : function(ed, url) {
      ed.addCommand('mceSomosLink', function() {
        ed.windowManager.open({
          //file : url + '/dialog.html',
          file : '/editor/link_dialog',
          width : 320 + ed.getLang('somoslink.delta_width', 0),
          height : 120 + ed.getLang('somoslink.delta_height', 0),
          inline : 1
        }, {
          plugin_url : url, // Plugin absolute URL
          some_custom_arg : 'custom arg' // Custom argument
        });
      });
  
      ed.addButton('somoslink', {
        title : 'somoslink.desc',
        cmd : 'mceSomosLink',
        image : url + '/img/somoslink.gif'
      });
  
      ed.onNodeChange.add(function(ed, cm, n) {
        cm.setActive('somoslink', n.nodeName == 'IMG');
      });
    },
  
    createControl : function(n, cm) {
      return null;
    },
  
    getInfo : function() {
      return {
        longname : 'SomosLink plugin',
        author : 'Some author',
        authorurl : 'http://tinymce.moxiecode.com',
        infourl : 'http://wiki.moxiecode.com/index.php/TinyMCE:Plugins/somoslink',
        version : "1.0"
      };
    }
  });

  tinymce.PluginManager.add('somoslink', tinymce.plugins.SomosLinkPlugin);
})();
