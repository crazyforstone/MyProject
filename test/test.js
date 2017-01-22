function TRS_Document_Source(urlname, urltitle, content) {
    if (urlname.indexOf('getNoticeList4Web.do') != -1) {
        eval('var c=' + content + ';');
        var source = '<html><body>';
        for (var i in c.rows) {
            source += '<a href="http://www.ccgp-hunan.gov.cn/portal/protalAction!viewNoticeContent.action?noticeId=' + c.rows[i].NOTICE_ID + '&area_id=">' + c.rows[i].NOTICE_TITLE + '</a>';
        }
        return source + '</body></html>';
    } else {
        var begin = content.indexOf('<body>');
        content = content.subString(begin);
        var source = '<html>';
        source += '<div class="title">' + urltitle + '</div>';
        source += '<div class="content">';
        source += content;
        source += '</div>' + begin + '</html>';
        return source;
    }
}
