import React, { useState, useEffect } from "react";
import { Fetch } from "../hooks/Fectch";
import CodeMirror from "./CodeMirror";
import "./Editor.css";

export default function Editor() {
  const [text, setText] = useState("");
  let url = "localhost:3001/api/analizar";

  useEffect(() => {
    // algo aqui

    let { data, isPending, error } = Fetch(url);
  }, [text]);

  const analizar = () => {};

  return (
    <>
      <div className='editor-container'>
        <div className='editor'>
          <h2>Editor de Codigo</h2>
          <CodeMirror read={false} />
          <div className='toolbar'>
            <select name='select' value='Abrir' onChange={() => {}}>
              <option value='Abrir'>Abrir Archivo</option>
              <option value='Guardar'>Guardar</option>
              <option value='Guardar Como'>Guardar Como</option>
            </select>
            <button onClick={analizar}>Analizar</button>
          </div>
        </div>
        <div className='console'>
          <h2>Consola de Salida</h2>
          <CodeMirror read={true} value={text} />
        </div>
      </div>
    </>
  );
}
