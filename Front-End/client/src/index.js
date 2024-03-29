import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import "./index.css";
import reportWebVitals from "./reportWebVitals";
import Editor from "./components/Editor";
import Navbar from "./components/Navbar";
import ListaErrores from "./components/ListaErrores";
import Ast from "./components/Ast/Ast";
import TablaSimbolos from "./components/TablaSimolos/TablaSimbolos";
const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <BrowserRouter>
    <Navbar />
    <Routes>
      <Route path='/' element={<Editor />} />
      <Route path='/errores' element={<ListaErrores />} />
      <Route path='/ast' element={<Ast />} />
      <Route path='/reportTs' element={<TablaSimbolos />} />
    </Routes>
  </BrowserRouter>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
