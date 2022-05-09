window.onerror = function (message, source, lineno, colno, error){
   document.querySelector('body').innerHTML = JSON.stringify(["js-error",message, source, lineno, colno, error])
}


class UI {
  bindingElements = []
  defaultBG = '#334';
  #url = '';
  #player = null;
  constructor (){
    this.$ = document.querySelector('.ui-wrapper');
    this.mount();
    this.countID = 0;

  }
  mount (){
    this.getPlayer();
    this.$.addEventListener('click', e=>{
            if(e.target.tagName!=='BUTTON') return;
            if(e.target.dataset.bind) this.getData();
    });
  }
  bind (id){
    if(id!=='nil'&&id!==undefined){
      this.bindingElements.push(id)
    }
  }
  getPlayer (){
      try {
          window.mcefQuery({
            request: "info",
            persistent: true,
            onSuccess: response=>{
              this.player = JSON.parse(response)
            },
            onFailure: function(errCode, errMsg) {
                   new Error(errCode, errMsg)
            }
              
          })

      } 
      catch (err) {
          new Error(err)
      }
  }
  get player (){
    return this.#player;
  }
  set player (val){
    this.#player = val;
  }
  getData (){

    const data = {
            player_name: this.player.name,
            player_uuid: this.player.uuid,
    };
    this.bindingElements.map( (id)=>{
        const el = document.querySelector(`[data-bind="${id}"]`)
        if(el.getAttribute('type')==='checkbox'){
            data[id] = el.checked;
        }
        if(el.getAttribute('type')==='text'){
            data[id] = el.value;
        }
    })


    const u = JSON.stringify(data)
    const url = `${this.url}/?${u}`;
    fetch(url);
  }
  get url (){
    return this.#url;
  }
  set url (val){
    this.#url = val;
  }
  append (html){
    this.$.innerHTML += html;
  }
  button (content, _type, left, top, lang, bind_id){
    const text = textFormat(content,  lang);
    const _id = ++this.countID;
    const btn = document.createElement('button')
    btn.classList.add('ui-button')
    btn.classList.add(typeFormat(_type))
    btn.id = 'button_'+_id
    btn.style = `position:absolute; left: ${left}px; top: ${top}px;`
    btn.innerText = text;

    if(bind_id!=='nil'&&bind_id!==undefined){
        btn.dataset.bind=bind_id;
    }
    document.querySelector('.ui-wrapper').appendChild(btn)
  }
  checkbox (content, left, top,  checked,  lang, bind_id){
    
    this.bind(bind_id)
    const text = textFormat(content,  lang);
    const _id = ++this.countID;
    const tpl = `<div class="ui-checkbox" ${styleFormat(left, top)}>
                    <input id="checkbox_${_id}" data-bind="${bind_id}" type="checkbox" ${checked?'checked':''} />
                    <label for="checkbox_${_id}">${text}</label>
                </div>`
    this.append(tpl);
  
  }
  radio (content, left, top, lang, bind_id){

      this.bind(bind_id)
      const getItems = ()=>{
      return content.map( (node, index)=>{
                const _id = ++this.countID;
                const text = textFormat(node,  lang);
                return `<div class="ui-radio">
                                <input id="radio_${_id}" type="radio" name="radio" ${index===0?'checked':''} />
                                <label for="radio_${_id}">${text}</label>
                        </div>`;
             }).join('');
    }
    const tpl = `<div class="ui-input-group" ${styleFormat(left, top)}>${getItems()}</div>`;
    this.append(tpl);
  }

  switch_2 (content, left, top, checked, lang, bind_id){
    const text = textFormat(content,  lang);
    const _id = ++this.countID;
    this.bind(bind_id)
    const tpl = ` <div class="ui-switch" ${styleFormat(left, top)}>
                    <input type="checkbox" id="checkbox_${_id}" data-bind="${bind_id}" ${checked?'checked':''} />
                    <label for="checkbox_${_id}">${text}</label>
                 </div>`;
    this.append(tpl);
  }
  input (content, label, left, top, lang, bind_id){
    this.bind(bind_id)
    const text = textFormat(content,  lang);
    const _label = textFormat(label,  lang);
    const _id = ++this.countID
    const tpl = ` <div class="ui-input" ${styleFormat(left, top)}>
                    <label for="input_${_id}">${_label}</label>
                    <input type="text" value="${text}" id="input_${_id}" data-bind="${bind_id}"/>
                 </div>`
    this.append(tpl);
  }
  items (content, left, top, lang){
 
      const getItems = ()=>{
      return content.map( (node, index)=>{
                const text = textFormat(node,  lang);
                return `<li>${text}</li>`;
             }).join('');
    }
    const tpl = `<ul class="ul-group" ${styleFormat(left, top)}>${getItems()}</ul>`;
    this.append(tpl);
  }
  image (url, left, top, width, height){
    const tpl = `<img src="${url}" ${styleFormat (left, top, width, height)} />`;
    this.append(tpl);
  }
  block (borderWidth=0, borderColor, backgroundColor, left, top, width, height){

    const style = `position:absolute;border-radius:3px; left: ${left}px; top: ${top}px;width:${width}px;height:${height}px; border: ${borderWidth}px solid ${borderColor};background-color: ${backgroundColor}`
    const tpl = `<div style='${style}'></div>`;
    this.append(tpl);
  }
  color (color){

    this.$.style.backgroundColor = color;
  }
  clear (){
    this.$.innerHTML = '';
    this.color(this.defaultBG)
  }
  name (bind_id){

    this.bind("name")
    const _id = ++this.countID
    const tpl = ` <input style="display:none;" type="text" value="${bind_id}" id="input_${_id}" data-bind="name"/>`
    this.append(tpl);

  }
  table (content, headColor, tableColor, left, top, width, height, lang){
    const getHead = () =>{
      return content[0].map(item=>{
                const text = textFormat(item,  lang);
                return `<th>${text}</th>`;
      }).join('');
    }

    const getTableCell = row =>{
        

     return row.map(cell=>{
                const text = textFormat(cell,  lang);
                return `<td>${text}</td>`;
             }).join('')


    }

    const getItems = ()=>{

      content.shift()
      return content.map( (row, index)=>{
                return `<tr>
                            ${getTableCell(row)}
                        </tr>`;
             }).join('');
    }

    const tpl =  `<div  ${styleFormat(left, top, width, height)}><table class="ui-table">
                    <thead style="color: ${headColor}">
                        <tr>
                          ${getHead()}
                        </tr>
                    </thead>
                    <tbody style="color: ${tableColor}">
                        ${getItems()}
                    </tbody>
                  </table></div>`
    this.append(tpl);             
  }
}




window.onload = function (){

  window.ui = new UI()

  /*
ui.checkbox('Variant', 400, 10, true, 'ru', 'checkbox_1')
ui.checkbox('Variant 2', 400, 50, false, 'ru')
ui.switch_2('test 1', 400, 300, true, null, 'bind_id-2')
ui.switch_2('test 2', 400, 350, true, null)

ui.input('Pole dlyf vvoda', 400, 370, 'ru', 'id-inputData')
ui.button('Soranit', 'success', 10, 350, 'ru', 'click_btn')
*/


}


/**
 *
 input.value = 'test'
 player.id
 ui.name('formID')
 *
 * 
 */