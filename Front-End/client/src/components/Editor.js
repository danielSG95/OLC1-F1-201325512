import React, { useState } from "react";
import CodeMirror from "./CodeMirror";
import ConsolaApp from "./Console";
import "./Editor.css";
import Toolbar from "./Toolbar";

export default function Editor() {
  const [text, setText] = useState("");
  const [newData, setNewData] = useState(">> Hello Friend...");
  const url = "http://localhost:3001/api/analizar";

  const handlerClick = async () => {
    try {
      const response = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "text/plain",
        },
        body: text,
      });

      if (!response.ok) {
        throw new Error(`Error! status: ${response.status}`);
      }
      const result = await response.json();
      console.log(JSON.stringify(result));
      setNewData(result.payload);
    } catch (error) {
      console.log(error);
    }
  };

  const loadFileText = (nText) => {
    setText(nText);
  };

  const cleanEditor = () => {
    setText("");
  };

  const onChangeText = (nuevo) => setText(nuevo);

  return (
    <>
      <div className='editor-container'>
        <div className='editor'>
          <h2>Editor de Codigo</h2>
          <CodeMirror read={false} valor={text} onChangeText={onChangeText} />
          <Toolbar
            handlerClick={handlerClick}
            loadFileText={loadFileText}
            cleanEditor={cleanEditor}
          />
        </div>
        <div className='console'>
          <h2>Consola de Salida</h2>
          {/* <CodeMirror read={false} valor={newData} onChangeText={test} /> */}
          <ConsolaApp read={true} valor={newData} />
        </div>
      </div>
    </>
  );
}
