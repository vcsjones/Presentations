$('pre[data-type=coffeescript]').each(->
    $t = $(@)
    $t.css('width', '49%').css('float', 'left')
    $jsblock = $('<pre class=\'prettyprint\' style=\'float:right; width: 49%\' />')
    $jsblock.text(CoffeeScript.compile($t.text()))
    $t.after($jsblock)
    $jsblock.after($('<div style=\'clear: both\'></div>'))
)
prettyPrint()
$('body').on('click', 'button[data-run]', ->
    $t = $(this)
    run = $t.data 'run'
    target = $("##{run}")
    src = target.text()
    if target.data('type') is 'coffeescript'
        CoffeeScript.eval(src)
    else
        eval(src)
)

$('#runbutton').click(->
    alert $(@).attr('id')
)

$('#ajaxrunbutton').click(->
    $.getJSON('jsonresponse.json', (d) =>
        $(@).text(d.message);
    )
)