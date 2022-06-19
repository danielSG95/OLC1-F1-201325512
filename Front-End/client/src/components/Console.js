import React, { useState, useEffect } from "react";

import CodeMirror from "@uiw/react-codemirror";
import { oneDark } from "@codemirror/theme-one-dark";

export default function ConsolaApp({ read, valor }) {
  const [content, setContent] = useState("");

  useEffect(() => {
    setContent(valor);
    console.log("cambiando data " + valor);
  }, [valor]);

  return (
    <CodeMirror
      value={content}
      minWidth='100%'
      maxWidth='100%'
      minHeight='450px'
      maxHeight='450px'
      readOnly={read}
      theme={oneDark}
      onChange={(v) => {
        // onChangeText(v);
        console.log(v);
      }}
    />
  );
}
