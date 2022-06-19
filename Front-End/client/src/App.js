import './App.css';
import Editor from './components/Editor';
import Navbar from './components/Navbar';


function App() {
  return (
    <>
      <Navbar />
      <main className='editor-container'>

        <Editor />
      </main>
    </>


  );
}

export default App;
