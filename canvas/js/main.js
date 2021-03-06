window.onerror = function (message, source, lineno, colno, error){
   document.querySelector('body').innerHTML = JSON.stringify(["js-error",message, source, lineno, colno, error])
}
// replaceAll polyfill
if (!String.prototype.replaceAll) {
  String.prototype.replaceAll = function(str, newStr){
    if (Object.prototype.toString.call(str).toLowerCase() === '[object regexp]') {
      return this.replace(str, newStr);
    }
    return this.replace(new RegExp(str, 'g'), newStr);

  };
}
/**/
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

function drawPoints (points, color,  radius){
  points.forEach(point=>{
    const p = new  Circle({
        radius : radius||3,
        fill : color,
        top : point[1],
        left : point[0]
      })
    canvas.add(p)
  })
}




window.onload = function (){
  window.canvas =  new Canvas('screen');
  /*
  const points = [
  [100, 100],
  [110, 110],
  [120, 120],
  [130, 130]
]
  drawPoints (points, 'magenta', 4)
*/
}



const dictonary = {
    "a A": 'а',
    "b B": 'б',
    "v V": 'в',
    "g G": 'г',
    "d D": 'д',
    "e E": 'е',
    "yo jo Yo Jo": 'ё',
    "zh Zh": 'ж',
    "z Z": 'з',
    "i I": 'и',
    "yi ji Yi Ji": 'й',
    "k K": 'к',
    "l L": 'л',
    "m M": 'м',
    "n N": 'н',
    "o O": 'о',
    "p P": 'п',
    "r R": 'р',
    "s S": 'с',
    "t T": 'т',
    "u U": 'у',
    "f F": 'ф',
    "x X": 'х',
    "c C": 'ц',
    "ch Ch": 'ч',
    "sh Sh": 'ш',
    "sch Sch": 'щ',
    "tzn Tzn": 'ъ',
    "jy Jy": 'ы',
    "mzn Mzn": 'ь',
    "ye je Ye Je": 'э',
    "yu ju Yu Ju": 'ю',
    "ya ja Ya Ja": 'я'
}

function textFormat(originalText, options,  lang){
  let text = String(originalText)
  if(lang==='ru'){
    const sortedArr = Object.keys(dictonary)
                            .sort((a,b)=>{
                                    if(a.length>b.length) return -1;
                                    if(a.length<b.length) return 1;
                                    return 0;
                            })
          sortedArr.map(keyENG=>{
                  let keys = keyENG.split(' ')
                  keys.map(k=>{
                      if(k===k.toUpperCase()){
                        text = text.replaceAll(k, dictonary[keyENG].toUpperCase())  
                      }
                      else{
                        text = text.replaceAll(k, dictonary[keyENG])
                      }
                  })
            })
  }
  canvas.add(new Text(text, options))
}

