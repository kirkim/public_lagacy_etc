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

fs.promises.readdir(workingDir, (err, files) => {
	if(err) {
		throw err;
	}
	files.forEach((file) => {
		const extName = path.extname(file);
		let mainPath;
		if (extName === '')
			return ;
		if (extName === '.png' || extName === '.aae') {
			mainPath = 'captured';
		} else if (extName === '.mp4' || extName === '.mov') {
			mainPath = 'video';
		} else if (fs.existsSync(path.join(workingDir, file.replace('_', '_E')))) {
			mainPath = 'duplicated';
		}
		if (mainPath) {
			fs.rename(path.join(workingDir, file), path.join(workingDir, mainPath, file), (err) => {
				if (err ===undefined || err == null) {
					/* 오류 처리 */
				}
			})
		}
	})
});
