import { useState, useEffect } from "react";
import "./TablaSimbolos.css";
export default function TablaSimbolos() {
  const [reportNames, setReportNames] = useState([]);
  const [data, setData] = useState(null);
  const [error, setError] = useState(false);
  const [count, setCount] = useState(0);

  const apiUrl = "http://localhost:3001/api/";
  useEffect(() => {
    const getNames = async (url) => {
      try {
        const response = await fetch(url, {
          method: "GET",
          headers: {
            "Content-Type": ["text/plain", "application/json"],
          },
        });

        if (!response.ok) {
          throw new Error(`Error! status: ${response.status}`);
        }
        const result = await response.json();
        // console.log(JSON.stringify(result));
        console.log(result.payload);
        setReportNames(JSON.parse(result.payload));
      } catch (error) {
        console.log(error);
      }
    };

    getNames(apiUrl + "getTsNames");
    getNextTs();
  }, [error]);

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

  const getNextTs = async () => {
    if (count < reportNames.length) {
      setCount(count + 1);
    }
    const [response, error] = await getData(
      `${apiUrl}getTsFile/${reportNames[count]}`
    );

    if (error) {
      console.log(error);
    } else {
      setData(response);
    }
  };

  const getPrevTs = async () => {
    if (count >= 1) {
      setCount(count - 1);
    }

    const [response, error] = await getData(
      `${apiUrl}getTsFile/${reportNames[count]}`
    );

    if (error) {
      console.log(error);
    } else {
      setData(response);
    }
  };

  return (
    <>
      <h2>Reporte de Tabla de Simbolos</h2>
      {data ? (
        <div className='container'>
          <img src={data} alt='Tabla de Simbolos' />
          <p>{reportNames[count]}</p>
          <div className='pn-btn'>
            <button onClick={getPrevTs}>prev</button>
            <button onClick={getNextTs}>next</button>
          </div>
        </div>
      ) : (
        <div>
          <h3>RIP</h3>
        </div>
      )}
    </>
  );
}
