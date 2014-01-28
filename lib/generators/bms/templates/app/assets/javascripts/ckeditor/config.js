CKEDITOR.stylesSet.add( 'my_styles',
    [
        { name : 'Мой стиль' , element : 'span', attributes : { 'class' : 'my-style' } },
        { name : 'Мой стиль' , element : 'div', attributes : { 'class' : 'my-style-2' } }
    ]);

CKEDITOR.config.stylesSet = 'my_styles';

CKEDITOR.config.filebrowserBrowseUrl = '/ckeditor/attachment_files';

CKEDITOR.config.filebrowserUploadUrl = '/ckeditor/attachment_files';

CKEDITOR.config.filebrowserImageUploadUrl = '/ckeditor/pictures';

CKEDITOR.config.filebrowserImageBrowseUrl = '/ckeditor/pictures';