import { useEffect, useState } from "react";
import "./App.css";
import { fetchNui } from "../utils/fetchNui";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { init } from 'console-ban';

export default function App() {
  const [Fetchvar1, setVar] = useState<string>('');
  const [Fetchvar2, setVar2] = useState<string>('');
  const [stillvarreceived, setstillvarreceived] = useState<boolean>(false);
  const [isUrlBlocked, setisUrlBlocked] = useState<boolean>(false);
  useNuiEvent("CheckRequest", (data: any) => {
    setVar(data?.varone);
    setVar2(data?.vartwo);
    setstillvarreceived(true);
  });
  useNuiEvent("IsUrlBlockCheck", (data: any) => {
    fetchNui('CheckWorking', {data:data, isUrlBlocked:isUrlBlocked});
  });
  // setInterval(() => {
  //   if (stillvarreceived && Fetchvar1 !== '' && Fetchvar2 !== '') {
  //     init({
  //       callback() {
  //         fetchNui(Fetchvar1, {});
  //         fetchNui(Fetchvar2, {});
  //       },
  //     });
  //   };
  // }, 1000);
  useEffect(() => {
    init({
      callback() {
        setisUrlBlocked(true);
        // setInterval(() => {
        //   if (stillvarreceived) {
        //     fetchNui(Fetchvar1, {});
        //     fetchNui(Fetchvar2, {});
        //   }
        // }, 1000);
      },
    });
  }, [])

  return (
    <div className="nui-wrapper">
    </div>
  );
}
