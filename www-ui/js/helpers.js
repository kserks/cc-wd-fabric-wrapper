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

function textFormat(originalText,  lang){
  let text = originalText
  if(lang==='ru'){
      Object.keys(dictonary)
            // длинные ключи заменяем первыми, что бы не поломать их, если короткие
            // будут стоять раньше
            .sort((a,b)=>{
                    if(a.length<b.length) return 1;
            })
            .map(keyENG=>{
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
  return text;
}

/**
 * Тип кнопки
 */

function typeFormat (type){
  const splittedType = type.split('');
  const firstLetter = splittedType[0].toUpperCase()
  splittedType.splice(0, 1)
  const status = firstLetter + splittedType.join('');
  return `is${status}`
}


function styleFormat (left, top){
  return `style='position:absolute; left: ${left}px; top: ${top}px;'`
}
