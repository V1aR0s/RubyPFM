document.addEventListener(
    "DOMContentLoaded",
    () => {
      document.getElementById("cbx-3").onchange = nonactiveinputs;
    },
    false
  );
  
  function nonactiveinputs() {
    let disabled_item = document.getElementsByClassName('custom-select');
    if (!document.getElementById("cbx-3").checked){
        document.getElementById("checkbox_select").disabled = true;
        
    }
    else{
        document.getElementById("checkbox_select").disabled = false;
         
    }


   
  }
  nonactiveinputs()