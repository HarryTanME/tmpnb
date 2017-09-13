//Insert wode.ai logo onto the notebook page.
if (IPython) {
  IPython._target = '_self';

  require(["base/js/events"], function (events) {
      events.on("notebook_loaded.Notebook", function () {
          var logoParent = document.getElementById("kernel_logo_widget")
var logo = document.getElementById("kernel_logo_widget").getElementsByClassName("current_kernel_logo")[0];
logo.src = "http://wode.ai/Portals/_default/skins/20073-unlimitedcolorspack-055/FileUploads/0/ai%20logo%202.png";
logo.style = "display: inline; width:40px; height:40px";
logoParent.innerHTML = '<a href="http://wode.ai" target="_blank">' + logoParent.innerHTML + '</a>';
          
      });
  });

}
