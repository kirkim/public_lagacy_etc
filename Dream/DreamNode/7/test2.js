const fs = require('fs');
const path = require('path');
const os = require('os');

const TARGET = process.argv[2];
const workingDir = path.join(os.homedir(), 'Desktop/Dream/DreamNode/7', TARGET);

if (TARGET == null || !fs.existsSync(workingDir)) {
	console.error("put valid filename!");
	return ;
}

const video = path.join(workingDir, 'video');
const captured = path.join(workingDir, 'captured');
const duplicated = path.join(workingDir, 'duplicated');

!fs.existsSync(video) && fs.mkdirSync(video);
!fs.existsSync(captured) && fs.mkdirSync(captured);
!fs.existsSync(duplicated) && fs.mkdirSync(duplicated);

fs.promises
	.readdir(workingDir)
	.then(processFiles)
	.catch(console.error);

function processFiles(files) {
	files.forEach((file) => {
		if (isCapturedFile(file)) {
			move(file, video);
		} else if (isVideoFile(file)) {
			move(file, captured);
		} else if (isDuplicatedFile(files, file)) {
			move(file, duplicated);
		}
	})
}

function isVideoFile(file) {
	// const extName = path.extname(file);
	// if (extName === '.mp4' || extName === '.mov')
	// 	return (true);
	// return (false);
	const regExp = /(mp4|mov)$/gm;
	const match = file.match(regExp);
	return (!!match);
}

function isCapturedFile(file) {
	// const extName = path.extname(file);
	// if (extName === '.png' || extName === '.aae')
	// 	return (true);
	// return (false);
	const regExp = /(png|aae)$/gm;
	const match = file.match(regExp);
	return (!!match);
}

// function isDuplicatedFile(file) {
// 	if (fs.existsSync(path.join(workingDir, file.replace('IMG_', 'IMG_E'))))
// 		return (true);
// 	return (false);
// }

function isDuplicatedFile(files, file) {
	// IMG_XXXX -> IMG_EXXX
	if (!file.startsWith('IMG_') || file.startsWith('IMG_E')) {
		return (false);
	}

	const edited = `IMG_E${file.split('_')[1]}`;
	const found = files.find(f => f.includes(edited));
	return (!!found);
}

function move(file, targetDir) {
	console.info(`move ${file} to ${path.basename(targetDir)}`);
	const oldPath = path.join(workingDir, file);
	const newPath = path.join(targetDir, file);
	fs.promises
		.rename(oldPath, newPath)
		.catch(console.error);
}
