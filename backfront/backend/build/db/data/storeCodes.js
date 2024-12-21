export let storeCodes;
function updateStoreCodes() {
    let codeBundle = [];
    for (let i = 0; i < 200; i++) {
        codeBundle.push(i.toString());
    }
    storeCodes = codeBundle;
}
updateStoreCodes();
