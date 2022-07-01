import React from "react";
import { Link } from "react-router-dom";
import "./Navbar.css";

export default function Navbar() {
  return (
    <nav className='navbar'>
      <div className='logo'>OLC1</div>
      <Link to='/'>Editor</Link>
      <Link to='/errores'>Errores</Link>
      <Link to='/ast'>Reporte AST</Link>
      <Link to='/reportTs'>Reporte TS</Link>
      <a
        href='https://github.com/danielSG95/OLC1-F1-201325512'
        className='gitContainer'
        target='__blank'
      >
        <figure>
          <img
            src='https://www.nicepng.com/png/full/52-520535_free-files-github-github-icon-png-white.png'
            alt='Github logo'
            className='github'
          ></img>
        </figure>
      </a>
    </nav>
  );
}
