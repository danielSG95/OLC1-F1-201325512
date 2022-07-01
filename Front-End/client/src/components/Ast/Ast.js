import { useEffect } from "react";
import { useState } from "react";
import InnerImageZoom from "react-inner-image-zoom";
import "./Ast.css";

export default function Ast() {
  const [data, setData] = useState(null);
  const [error, setError] = useState(true);

  const url = "http://localhost:3001/api/getAst";

  const getData = async (url) => {
    try {
      const response = await fetch(url, {
        method: "GET", // *GET, POST, PUT, DELETE, etc.
        mode: "cors", // no-cors, *cors, same-origin
        cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
        headers: {
          "Content-Type": "image/png",
        },
      });
      const blob = await response.blob();
      return [URL.createObjectURL(blob), null];
    } catch (error) {
      console.error(`get: error occurred ${error}`);
      return [null, error];
    }
  };

  useEffect(() => {
    const request = async (url) => {
      const [response, error] = await getData(url);
      if (error) {
        console.log(error);
      } else {
        console.log(response);
        setData(response);
      }
    };

    request(url);
  }, [error]);

  const download = () => {
    try {
      const link = document.createElement("a");
      link.href = data;
      link.setAttribute("download", "image.png"); //or any other extension
      document.body.appendChild(link);
      link.click();
    } catch (error) {}
  };

  return (
    <div className='container'>
      <h2>Reporte Ast</h2>

      {data ? (
        <div>
          <figure>
            <img src={data} alt='Tree Report' className='imgAst' />
          </figure>
          <button onClick={download}>Descargar Imagen</button>
        </div>
      ) : (
        <p></p>
      )}
    </div>
  );
}
