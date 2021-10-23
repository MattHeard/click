import { Elm } from "./Main";

var app = Elm.Main.init({
  node: document.querySelector("main"),
});

const handleStoreModel = (model) => {
  const modelJson = JSON.stringify(model);
  localStorage.setItem('model', modelJson);
  console.log("Saved state: ", modelJson);
};

app.ports.storeModel.subscribe(handleStoreModel);
