import app from './elm-init';

import idb from './port-handlers/idb-handlers';
import flickity from './port-handlers/flickity-handlers';
import hotspots from './port-handlers/hotspots-handlers';
import firebase from './port-handlers/firebase-handlers';

import defaultStims from '../json/defaultStims.json';

app.ports.initCarousel.subscribe(flickity.initCarousel);
app.ports.onboardingCarousel.subscribe(flickity.onboardingCarousel);
app.ports.videoCarousel.subscribe(flickity.videoCarousel);

app.ports.initHotspots.subscribe(hotspots.initHotspots);
app.ports.initDB.subscribe(() => idb.initDB(defaultStims));

app.ports.saveStim.subscribe(idb.saveStim);
app.ports.saveOrUpdateUser.subscribe(idb.saveOrUpdateUser);
app.ports.deleteStim.subscribe(idb.deleteStim);
app.ports.fetchFirebaseStims.subscribe(() => firebase.getFirebaseStims());
app.ports.shareStim.subscribe(stim => firebase.addFirebaseStim(stim));

app.ports.changeSkinColour.subscribe(arrayHexClass => {
  const getSvgDoc = cb => {
    let currentAvatar = document.querySelector(arrayHexClass[1]);
    if (arrayHexClass[1] == '.is-selected') {
      currentAvatar = currentAvatar.firstElementChild;
    }

    if (currentAvatar === null) return setImmediate(() => getSvgDoc(cb));

    const svgDoc = currentAvatar.contentDocument;
    const bodyElements = svgDoc.getElementById('body_change_colour');
    const headElements = svgDoc.getElementById('head');

    if (bodyElements === null) return setImmediate(() => getSvgDoc(cb));

    cb(bodyElements, headElements);
  };

  const updateSkinColour = (bodyElements, headElements) => {
    bodyElements.setAttribute('fill', arrayHexClass[0]);
    headElements.setAttribute('fill', arrayHexClass[0]);
  };

  getSvgDoc(updateSkinColour);
});
