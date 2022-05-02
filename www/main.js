window.onerror = function (error, url, line, columnNo, error){
   document.querySelector('body').innerHTML = JSON.stringify(["js-Error",error, url, line, columnNo, error]) 
   //setTimeout(location.reload, 2000)
}
function include_html (tpl){
    document.querySelector('body').innerHTML = tpl;
}
function include_style (style){
    document.querySelector('body').innerHTML += `<style>${style}</style>`;
}



fabric.Object.prototype.selectable = false;

const {
  Rect,
  Circle,
  Polyline,
  Polygon,
  Triangle,
  Canvas,
  Text,
  Image,
  Line
} = fabric;


/**
а a
б b
в v
г g
д d
е e
ё yo jo
ж zh
з z
и i
й yi ji
к k
л l
м m
н n
о o
п p
р r
с s
т t
у u
ф f
х x
ц c
ч ch
ш sh
щ sch
ъ tzn
ы jy
ь mzn
э ye je
ю yu ju
я ya ja

*/


window.onload = function (){
  window.canvas =  new Canvas('screen');

}

