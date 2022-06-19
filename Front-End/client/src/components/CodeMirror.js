import React, { useState, useEffect } from 'react';

import CodeMirror from '@uiw/react-codemirror';
import { oneDark } from '@codemirror/theme-one-dark';

export default function App({ read, value }) {
    const [content, setContent] = useState('');

    useEffect(() => {
        setContent(value)
    }, [content]);


    return (
        <CodeMirror
            value={content}
            minWidth='750px'
            maxWidth='750px'
            minHeight='450px'
            maxHeight='450px'
            readOnly={read}
            theme={oneDark}
            // extensions={[javascript]}
            onChange={(value, viewUpdate) => {
            }}
        />
    );
}