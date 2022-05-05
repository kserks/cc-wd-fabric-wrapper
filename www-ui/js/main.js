window.onerror = function (error, url, line, columnNo, error){
   document.querySelector('body').innerHTML = JSON.stringify(["js-error",error, url, line, columnNo, error])
}


class UI {
  bindingElements = []
  constructor (){
    this.$ = document.querySelector('.ui-wrapper');
    this.mount();

  }
  mount (){
    this.$.addEventListener('click', e=>{
            if(e.target.tagName!=='BUTTON') return;
            if(e.target.dataset.bind) this.getData();
    });
  }
  bind (id){
    if(id!=='nil'){
      this.bindingElements.push(id)
    }
  }
  getData (){
    const data = []
    this.bindingElements.map( (id)=>{
        const el = document.querySelector(`[data-bind="${id}"]`)
        if(el.getAttribute('type')==='checkbox'){
            data.push({ id, checked: el.checked})
        }
        if(el.getAttribute('type')==='text'){
            data.push({ id, value: el.value})
        }
    })


    const u = new URLSearchParams(data).toString();
    //this.$.innerHTML = JSON.stringify(data)
    fetch('http://localhost:60000/0/'+'?'+u)
  }
  append (html){
    this.$.innerHTML += html;
  }
  button (content, _type, left, top, lang, bind_id){
    const text = textFormat(content,  lang);
    const id = `button_${new Date().getTime()}`;
    const btn = document.createElement('button')
    btn.classList.add('ui-button')
    btn.classList.add(typeFormat(_type))
    btn.id = id
    btn.style = `position:absolute; left: ${left}px; top: ${top}px;`
    btn.innerText = text;

    if(bind_id!=='nil'){
        btn.dataset.bind=bind_id
      

    }
    document.querySelector('.ui-wrapper').appendChild(btn)
  }
  checkbox (content, left, top,  checked,  lang, bind_id){
    
    this.bind(bind_id)
    const text = textFormat(content,  lang);
    const id = `checkbox_${new Date().getTime()}`;
    const tpl = `<div class="ui-checkbox" ${styleFormat(left, top)}>
                    <input id="${id}" data-bind="${bind_id}" type="checkbox" ${checked?'checked':''} />
                    <label for="${id}">${text}</label>
                </div>`
    this.append(tpl);
  
  }
  radio (content, left, top, lang, bind_id){
     // this.bind(bind_id)
      const getItems = ()=>{
      return content.map( (node, index)=>{
                const id = `radio_${new Date().getTime()}`;
                const text = textFormat(node,  lang);
                return `<div class="ui-radio">
                                <input id="${id}" type="radio" name="radio" ${index===0?'checked':''} />
                                <label for="${id}">${text}</label>
                        </div>`;
             }).join('');
    }
    const tpl = `<div class="ui-input-group" ${styleFormat(left, top)}>${getItems()}</div>`;
    this.append(tpl);
  }

  switch_2 (content, left, top, checked, lang, bind_id){
    const text = textFormat(content,  lang);
    const id = `checkbox_${new Date().getTime()}`;

    this.bind(bind_id)
    const tpl = ` <div class="ui-switch" ${styleFormat(left, top)}>
                    <input type="checkbox" id="${id}" data-bind="${bind_id}" ${checked?'checked':''} />
                    <label for="${id}">${text}</label>
                 </div>`;
    this.append(tpl);
  }
  input (content, left, top, lang, bind_id){
    this.bind(bind_id)
    const text = textFormat(content,  lang);
    const time = new Date().getTime();
    const tpl = ` <div class="ui-input" ${styleFormat(left, top)}>
                    <label for="input_${time}">${text}</label>
                    <input type="text" value="" id="input_${time}" data-bind="${bind_id}"/>
                 </div>`
    this.append(tpl);
  }
  list (content, left, top, lang, bind_id){
     // this.bind(bind_id)
      const getItems = ()=>{
      return content.map( (node, index)=>{
               
                const text = textFormat(node,  lang);
                return `<li>${text}</li>`;
             }).join('');
    }
    const tpl = `<ul ${styleFormat(left, top)}>${getItems()}</ul>`;
    this.append(tpl);
  }
}




window.onload = function (){

  window.ui = new UI()

/*
  ui.checkbox('Variant', 400, 10, true, 'ru', 'checkbox_1')
  ui.checkbox('Variant 2', 400, 50, false, 'ru')





  ui.switch_2('Perekluchatel', 400, 220, true, 'ru', 'bind_id-1')
  ui.switch_2('test 1', 400, 400, true, 'bind_id-2')
  ui.switch_2('test 2', 400, 600, true)

  ui.input('Pole dlyf vvoda', 0, 370, 'ru', 'id-inputData')
  ui.input('Pole dlyf vvoda 2', 0, 450, 'ru')
 */
}

