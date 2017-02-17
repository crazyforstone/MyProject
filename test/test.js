function radar_content() {
    this.source = "";
}


function TRS_Document_Source(urlname, urltitle, content) {
    var temp;
    var rval = new radar_content();
    var getPageDataList = function() {
        var cNumber = document.getElementById("currentCategoryNumber").value;
        var piclist = document.getElementById("PageListCount").value;
        var cPage = document.getElementById("currentPage").value;

        if (cNumber != "NC-03") piclist = 20;

        var reM = Eep.CompanyWebSite.WebSite.MethodMF.getENewsInfoDataOfPage("NC-01", 20, 1);
        if (reM.error) {
            alert(reM.error.Message);
            return;
        } else if (reM.value != null && typeof(reM.value) == "object") {
            if (!reM.value.Succeed) {
                document.getElementById("contentDiv").innerHTML = "<span style='color:Red'>" + reM.value.Message + "</span>";
                return;
            } else {
                return reM.value.Data[0];
            }
        }
    }
    return rval.source = getPageDataList();
}
