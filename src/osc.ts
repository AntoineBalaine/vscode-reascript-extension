const koffi = require('koffi');

import { arch, cpus, tmpdir, homedir } from 'os';
import { extensionBasePath } from './extension.js';

export function InitializeFFI()
{
	let asdf = extensionBasePath + (arch() === 'x64' ? '/lib/x64/' : '/lib/x86/') + 'OSC2AHK.dll'

	const libD = {
		user32: koffi.load("user32.dll"),
		osc: koffi.load(extensionBasePath + (arch() === 'x64' ? '/lib/x64/' : '/lib/x86/') + 'OSC2AHK.dll')
	}

	const lib =
	{
		osc: {
			open: libD.osc.func("int open(void *targetWindowHandle, unsigned int port);"),
			close: libD.osc.func("int close(unsigned int clearListeners);"),
			addListener: libD.osc.func("int addListener(str address, unsigned int messageID, unsigned int dataType);"),
			removeListener: libD.osc.func("int removeListener(str address);"),
			getStringData: libD.osc.func("char* getStringData(char* targetString, unsigned int targetSize, unsigned int StringID);"),
			sendOscMessageInt: libD.osc.func("void sendOscMessageInt(char* ip, unsigned int port, char* address, int payload);"),
			sendOscMessageInt2: libD.osc.func("void sendOscMessageInt2(char* ip, unsigned int port, char* address, int payload1, int payload2);"),
			sendOscMessageFloat: libD.osc.func("void sendOscMessageFloat(char* ip, unsigned int port, char* address, float payload);"),
			sendOscMessageFloat2: libD.osc.func("void sendOscMessageFloat2(char* ip, unsigned int port, char* address, float payload1, float payload2);"),
			sendOscMessageString: libD.osc.func("void sendOscMessageString(char* ip, unsigned int port, char* address, char* payload);"),
			sendOscMessageString2: libD.osc.func("void sendOscMessageString2(char* ip, unsigned int port, char* address, char* payload1, char* payload2);"),
			},
		user32: {
			MessageBoxA: libD.user32.func('__stdcall', 'MessageBoxA', 'int', ['void *', 'str', 'str', 'uint']),
			MessageBoxW: libD.user32.func("int MessageBoxW(void *hWnd, str16 lpText, str16 lpCaption, uint uType);")
		}
	}

	return lib
}
