import React from "react";
import "./Navbar.css";

export default function Navbar() {
  return (
    <nav className='navbar'>
      <div className='logo'>OLC1</div>
      <a href='/'>Editor</a>
      <a href='/'>Reportes</a>
      <a href='/'>Acerca De</a>
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
