import React, { useRef } from "react";
import "./Editor.css";
export default function Toolbar({ handlerClick, loadFileText, cleanEditor }) {
  const inputFile = useRef(null);

  const openFile = () => {
    inputFile.current.click();
  };

  const onChangeFile = (event) => {
    event.stopPropagation();
    event.preventDefault();
    let file = event.target.files[0];
    let reader = new FileReader();
    reader.onload = (event) => {
      loadFileText(event.target.result);
    };
    reader.readAsText(file);
  };

  return (
    <div className='toolbar'>
      <input
        type='file'
        id='file'
        ref={inputFile}
        style={{ display: "none" }}
        onChange={onChangeFile}
      />
      <button className='openFile' onClick={openFile}>
        Abrir Archivo
      </button>
      <button className='saveFile'>Guardar</button>
      <button className='cleanEditor' onClick={cleanEditor}>
        Limpiar
      </button>
      <button className='analizarData' onClick={handlerClick}>
        Analizar
      </button>
    </div>
  );
}
