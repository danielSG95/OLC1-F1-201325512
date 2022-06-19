import React, { useState, useEffect } from "react";

import CodeMirror from "@uiw/react-codemirror";
import { oneDark } from "@codemirror/theme-one-dark";

export default function CodeEditor({ read, valor, onChangeText }) {
  const [content, setContent] = useState("");

  useEffect(() => {
    setContent(valor);
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
      // extensions={[javascript]}
      onChange={(v) => {
        onChangeText(v);
      }}
    />
  );
}
