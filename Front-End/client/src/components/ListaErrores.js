import { useEffect } from "react";
import { useState } from "react";
import "./ListaErrores.css";
export default function ListaErrores() {
  const [data, setData] = useState([]);
  const [error, setError] = useState(true);

  const url = "http://localhost:3001/api/getErrores";
  useEffect(() => {
    const handlerClick = async (url) => {
      try {
        const response = await fetch(url, {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
          },
        });

        if (!response.ok) {
          throw new Error(`Error! status: ${response.status}`);
        }
        const result = await response.json();
        setData(result.res);
        console.log(data);
      } catch (error) {
        console.log(error);
        setError(true);
      }
    };

    handlerClick(url);
  }, [error]);

  return (
    <>
      <div className='container'>
        <h2>Reporte de Errores</h2>
        <ul className='responsive-table'>
          <li className='table-header'>
            <div className='col col-1'>Linea</div>
            <div className='col col-3'>Columna</div>
            <div className='col col-4'>Descripcion</div>
            <div className='col col-4'>Lexema</div>
            <div className='col col-4'>Tipo Error</div>
          </li>
          {data ? (
            data.map((e, key) => (
              <li className='table-row' key={key}>
                <div key={key} className='col col-1' data-label='Linea'>
                  {e.linea}
                </div>
                <div key={e.line} className='col col-3' data-label='Columna'>
                  {e.columna}
                </div>
                <div className='col col-4' data-label='Descripcion'>
                  {e.descripcion}
                </div>
                <div className='col col-4' data-label='Lexema'>
                  {e.lexema.value}
                </div>
                <div className='col col-4' data-label='Tipo Error'>
                  {e.tipo}
                </div>
              </li>
            ))
          ) : (
            <h2>No errores</h2>
          )}
        </ul>
      </div>
    </>
  );
}
