import { Elm } from "./Main";

var storedState = localStorage.getItem('model');
var startingState = storedState ? JSON.parse(storedState) : null;

var app = Elm.Main.init({
  node: document.querySelector("main"),
  flags: startingState,
});

const handleStoreModel = (model) => {
  const modelJson = JSON.stringify(model);
  localStorage.setItem('model', modelJson);
};

app.ports.storeModel.subscribe(handleStoreModel);
