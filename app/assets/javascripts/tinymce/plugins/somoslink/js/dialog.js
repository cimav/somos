tinyMCEPopup.requireLangPack();

var SomosLinkDialog = {
  init : function() {
    // Get the selected contents as text and place it in the input
    $('#selected_value').val(tinyMCEPopup.editor.selection.getContent({format : 'text'}));
  },

  insert : function() {
    // Insert the contents from the input into the document
    // tinyMCEPopup.editor.execCommand('mceInsertContent', false, document.forms[0].url.value);
    if ($('#link_type').val() == 'URL') {
      url = '<a href="' + $('#url').val() + '" class="external-link">' + $('#selected_value').val() + '</a>';
    } else if ($('#link_type').val() == 'PAGE') {
      url = '<a href="' + $('#page_url').val() + '" class="page-link">' + $('#selected_value').val() + '</a>';
    } else if ($('#link_type').val() == 'FILE') {
      url = '<a href="' + $('#selected_file').val() + '" class="file-link">' + $('#selected_value').val() + '</a>';
    }
    tinyMCEPopup.editor.execCommand('mceInsertContent', false, url);
    tinyMCEPopup.close();
  }
};

tinyMCEPopup.onInit.add(SomosLinkDialog.init, SomosLinkDialog);
