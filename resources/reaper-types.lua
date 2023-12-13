---@meta
reaper = {}
gfx = {}

---@alias ReaProject integer
---@class HWND
---@class MediaTrack
---@class MediaItem
---@class MediaItem_Take
---@class AudioAccessor
---@class KbdSectionInfo
---@class TrackEnvelope
---@class PCM_source
---@class IReaperControlSurface
---@class reaper.array
---@class joystick_device
---@class takename
---@class BR_Envelope
---@class RprMidiTake
---@class RprMidiNote
---@class WDL_FastString
---@class AudioWriter
---@class FxChain
---@class CF_Preview
---@class gfx
---@class ReaperArray
---@alias identifier
---| ReaProject 
---| HWND
---| MediaTrack
---| MediaItem
---| MediaItem_Take
---| AudioAccessor
---| KbdSectionInfo
---| TrackEnvelope
---| PCM_source
---| IReaperControlSurface
---| reaper.array
---| joystick_device
---| takename
---| BR_Envelope
---| RprMidiTake
---| RprMidiNote
---| WDL_FastString
---| AudioWriter
---| FxChain
---| CF_Preview
---| gfx
---| ReaperArray
---| identifier

---@class PackageEntry
---@class ImGui_Context
---@class ImGui_Font
---@class ImGui_Image
---@class ImGui_DrawList
---@class ImGui_DrawListSplitter
---@class ImGui_Function
---@class ImGui_ImageSet
---@class ImGui_ListClipper
---@class ImGui_TextFilter
---@class ImGui_Viewport



---Creates a new media item. It will be empty and therefore not be shown in the arrange-view, until you associate a mediafile(audio, picture, video, etc) or a length and position to it using SetMediaItemInfo_Value
---@param tr MediaTrack
---@return MediaItem item
function reaper.AddMediaItemToTrack(tr) end

---Creates a new Projectmarker/Region.
---Returns the index of the created marker/region, or -1 on failure. Supply wantidx>=0 if you want a particular index number, but you'll get a different index number a region and wantidx is already in use.It will not create a marker, when at the same position is a marker with the exact name(a bug maybe?)
---@param proj ReaProject
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param name string
---@param wantidx integer
---@return integer index
function reaper.AddProjectMarker(proj, isrgn, pos, rgnend, name, wantidx) end

---Returns the shown-number of the created marker/region, or -1 on failure. Supply wantidx>=0 if you want a particular index number, but you'll get a different index number a region and wantidx is already in use. color should be 0 (default color), or ColorToNative(r,g,b)|0x1000000It will not create a marker, when at the same position is a marker with the exact name(a bug maybe?)
---@param proj ReaProject
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param name string
---@param wantidx integer
---@param color integer
---@return integer index
function reaper.AddProjectMarker2(proj, isrgn, pos, rgnend, name, wantidx, color) end

---Adds a ReaScript (returns the new command ID, or 0 if failed) or removes a ReaScript
---Returns >0 on success. 
---Use commit==true when adding/removing a single script. 
---Committing means, that Reaper stores the Reascript-information into the reaper-kb.ini for permanent use. 
---It will be committed at Reaper's exit as well, but if Reaper crashes before exiting properly, your added
---script might get lost. When adding many Reascripts to Reaper, setting commit to false might help prevail 
---ressources, as you don't rewrite the reaper-kb.ini file over and over again. However, if you only add a 
---few scripts, this might not be of importance to you.
---So when bulk adding/removing multiple scripts, you can optimize the n-1 first calls with commit==false and commit==true for the last call.The commandID returned, might change, when adding this script into another Reaper-installation. 
---To be sure to use the right command-id, use ReverseNamedCommandLookup() to get the ActionCommandID, which will never change, until you remove the script.If you want to add a script to several sections, you need to add them individually, by calling the function again with the changed section-number.
---@param add boolean
---@param sectionID integer
---@param scriptfn string
---@param commit boolean
---@return integer command_id
function reaper.AddRemoveReaScript(add, sectionID, scriptfn, commit) end

---creates a new take in an item
---@param item MediaItem
---@return MediaItem_Take take
function reaper.AddTakeToMediaItem(item) end

---Deprecated. Use SetTempoTimeSigMarker with ptidx=-1.
---@param proj ReaProject
---@param timepos number
---@param bpm number
---@param timesig_num integer
---@param timesig_denom integer
---@param lineartempochange boolean
---@return boolean retval
function reaper.AddTempoTimeSigMarker(proj, timepos, bpm, timesig_num, timesig_denom, lineartempochange) end

---Sets horizontal zoom in track view.
---@param amt number
---@param forceset integer
---@param doupd boolean
---@param centermode integer
function reaper.adjustZoom(amt, forceset, doupd, centermode) end

---returns, whether any of the tracks is solo in Project proj
---@param proj ReaProject
---@return boolean solostate
function reaper.AnyTrackSolo(proj) end

---Returns true if function_name exists in the REAPER API
---@param function_name string
---@return boolean func_exists
function reaper.APIExists(function_name) end

---Displays a message window with "Hello World", if the API was successfully called.
function reaper.APITest() end

---Nudges elements like items, cursor, contents, etc to or by a value you want. Nudges only selected mediaitems.
---@param project ReaProject
---@param nudgeflag integer
---@param nudgewhat integer
---@param nudgeunits integer
---@param value number
---@param reverse boolean
---@param copies integer
---@return boolean retval
function reaper.ApplyNudge(project, nudgeflag, nudgewhat, nudgeunits, value, reverse, copies) end

---open all audio and MIDI devices, if not openSo if the audio-device(s) are closed, you can use this to try to (re)-activate them.
function reaper.Audio_Init() end

---is in pre-buffer? threadsafe
---@return integer retval
function reaper.Audio_IsPreBuffer() end

---is audio running at all? threadsafeIt is an indicator, if the current audio-device is closed(0) or not(1).
---@return integer audio_running
function reaper.Audio_IsRunning() end

---close all audio and MIDI devices, if openThis sets all audio-devices to closed.
function reaper.Audio_Quit() end

---Returns true if the underlying samples (track or media item take) have changed, but does not update the audio accessor, so the user can selectively call AudioAccessorValidateState only when needed. 
---@param accessor AudioAccessor
---@return boolean changed_samples
function reaper.AudioAccessorStateChanged(accessor) end

---Force the accessor to reload its state from the underlying track or media item take. 
---@param accessor AudioAccessor
function reaper.AudioAccessorUpdate(accessor) end

---Validates the current state of the audio accessor -- must ONLY call this from the main thread. Returns true if the state changed.
---@param accessor AudioAccessor
---@return boolean statechange
function reaper.AudioAccessorValidateState(accessor) end

---Does bypassing of the fx of all tracks.
---@param bypass integer
function reaper.BypassFxAllTracks(bypass) end

---Calculates loudness statistics of media via dry run render. Statistics will be displayed to the user; call GetSetProjectInfo_String("RENDER_STATS") to retrieve via API. Returns 1 if loudness was calculated successfully, -1 if user canceled the dry run render.
---@param mediasource PCM_source
---@return integer retval
function reaper.CalcMediaSrcLoudness(mediasource) end

---Calculate normalize adjustment for source media. normalizeTo: 0=LUFS-I, 1=RMS-I, 2=peak, 3=true peak, 4=LUFS-M max, 5=LUFS-S max. normalizeTarget: dBFS or LUFS value. normalizeStart, normalizeEnd: time bounds within source media for normalization calculation. If normalizationStart=0 and normalizationEnd=0, the full duration of the media will be used for the calculation
---@param source PCM_source
---@param normalizeTo integer
---@param normalizeTarget number
---@param normalizeStart number
---@param normalizeEnd number
---@return number normalized_value
function reaper.CalculateNormalization(source, normalizeTo, normalizeTarget, normalizeStart, normalizeEnd) end

---Clears all armed states of all tracks.
function reaper.ClearAllRecArmed() end

---Clear the ReaScript console.
function reaper.ClearConsole() end

---resets the global peak caches
function reaper.ClearPeakCache() end

---Extract RGB values from an OS dependent color.As Reaper treats colors differently on Mac and Windows, you should always use ColorFromNative and ColorToNative.
---@param col integer
---@return integer r, integer g, integer b
function reaper.ColorFromNative(col) end

---Make an OS dependent color from RGB values (e.g. RGB() macro on Windows). r,g and b are in [0..255]. 
---As Reaper treats colors differently on Mac and Windows, you should always use ColorFromNative and ColorToNative.When using the returned colorvalue, you need to add |0x1000000 at the end of it, like ColorToNative(20,30,40)|0x1000000.
---@param r integer
---@param g integer
---@param b integer
---@return integer col
function reaper.ColorToNative(r, g, b) end

---Returns the number of shortcuts that exist for the given command ID.
---@param section KbdSectionInfo
---@param cmdID integer
---@return integer retval
function reaper.CountActionShortcuts(section, cmdID) end

---Returns the number of automation items on this envelope.
---@param env TrackEnvelope
---@return integer ai_count
function reaper.CountAutomationItems(env) end

---Returns the number of points in the envelope.
---@param envelope TrackEnvelope
---@return integer count_envpoints
function reaper.CountEnvelopePoints(envelope) end

---Returns the number of points in the envelope.
---autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
---For automation items, pass autoitem_idx|0x10000000 to base ptidx on the number of points in one full loop iteration,
---even if the automation item is trimmed so that not all points are visible.
---Otherwise, ptidx will be based on the number of visible points in the automation item, including all loop iterations.
---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@return integer count_envpoints
function reaper.CountEnvelopePointsEx(envelope, autoitem_idx) end

---count the number of items in the project (proj=0 for active project)
---@param proj ReaProject
---@return integer count_items
function reaper.CountMediaItems(proj) end

---returns the number of all markers and regions, as well as all markers and all regions in a project.
---num_markersOut and num_regionsOut may be NULL.
---@param proj ReaProject
---@return integer retval, integer num_markers, integer num_regions
function reaper.CountProjectMarkers(proj) end

---count the number of selected items in the project (proj=0 for active project)
---@param proj ReaProject
---@return integer count_sel_items
function reaper.CountSelectedMediaItems(proj) end

---Count the number of selected tracks in the project. 
---This function ignores the master track, see CountSelectedTracks2 if you need master-track as well.
---@param proj ReaProject
---@return integer count_sel_tracks
function reaper.CountSelectedTracks(proj) end

---Count the number of selected tracks in the project.
---if you set wantmaster to true, it will include the master track as well.
---@param proj ReaProject
---@param wantmaster boolean
---@return integer count_sel_tracks
function reaper.CountSelectedTracks2(proj, wantmaster) end

---Counts take-envelopes.
---@param take MediaItem_Take
---@return integer count_take_env
function reaper.CountTakeEnvelopes(take) end

---count the number of takes in the item
---@param item MediaItem
---@return integer count_takes
function reaper.CountTakes(item) end

---Count the number of FX parameter knobs displayed on the track control panel.
---@param project ReaProject
---@param track MediaTrack
---@return integer count_params
function reaper.CountTCPFXParms(project, track) end

---Count the number of tempo/time signature markers in the project.
---@param proj ReaProject
---@return integer count_tempo_markers
function reaper.CountTempoTimeSigMarkers(proj) end

---Counts the number of track-envelopes of a certain track.
---@param track MediaTrack
---@return integer count_track_envs
function reaper.CountTrackEnvelopes(track) end

---count the number of items in the track
---@param track MediaTrack
---@return integer count_trackitems
function reaper.CountTrackMediaItems(track) end

---count the number of tracks in the project (proj=0 for active project)
---@param proj ReaProject
---@return integer count_tracks
function reaper.CountTracks(proj) end

---Create a new MIDI media item, containing no MIDI events. Time is in seconds unless qn is set.
---@param track MediaTrack
---@param starttime number
---@param endtime number
---@param qn? boolean
---@return MediaItem item
function reaper.CreateNewMIDIItemInProj(track, starttime, endtime, qn) end

---Create an audio accessor object for this take. Must only call from the main thread. 
---@param take MediaItem_Take
---@return AudioAccessor acc
function reaper.CreateTakeAudioAccessor(take) end

---Create an audio accessor object for this track. Must only call from the main thread.
---@param track MediaTrack
---@return AudioAccessor acc
function reaper.CreateTrackAudioAccessor(track) end

---Create a send/receive (desttrInOptional!=NULL), or a hardware output (desttrInOptional==NULL) with default properties, return >=0 on success (== new send/receive index).For ReaRoute-users: the outputs are hardware outputs, but with 512 added to the destination channel index (512 is the first rearoute channel, 513 the second, etc).
---@param tr MediaTrack
---@param desttr MediaTrack
---@return integer retval
function reaper.CreateTrackSend(tr, desttr) end

---call this to force flushing of the undo states after using CSurf_On*Change()
---@param force boolean
function reaper.CSurf_FlushUndo(force) end

---@param trackid MediaTrack
---@param isPan integer
---@return boolean retval
function reaper.CSurf_GetTouchState(trackid, isPan) end

---Moves the cursor to the end of the last item in the project.
function reaper.CSurf_GoEnd() end

---Moves the cursor to the start of the project.
function reaper.CSurf_GoStart() end

---counts the number of tracks, or the number of visible tracks, when mcpView is set to true.
---@param mcpView boolean
---@return integer count_tracks
function reaper.CSurf_NumTracks(mcpView) end

---Zoom or scroll the Arrangeview vertically. 
---The stepsize with scrolling is track by track.
---@param whichdir integer
---@param wantzoom boolean
function reaper.CSurf_OnArrow(whichdir, wantzoom) end

---Moves editcursor forward, and optionally with seekplay.
---@param seekplay integer
function reaper.CSurf_OnFwd(seekplay) end

---Sets/toggles activation of FX-Chain.
---@param trackid MediaTrack
---@param en integer
---@return boolean active_fxchain
function reaper.CSurf_OnFXChange(trackid, en) end

---sets rec-monitoring of a specific track.
---@param trackid MediaTrack
---@param monitor integer
---@return integer inp_mon_state
function reaper.CSurf_OnInputMonitorChange(trackid, monitor) end

---Sets monitor-input-state. If MediaTrack is selected, among others, and allowgang is set to true, the new state will be set to them as well.
---@param trackid MediaTrack
---@param monitor integer
---@param allowgang boolean
---@return integer inp_mon_state
function reaper.CSurf_OnInputMonitorChangeEx(trackid, monitor, allowgang) end

---Sets mute state of a MediaTrack.
---@param trackid MediaTrack
---@param mute integer
---@return boolean mute_state
function reaper.CSurf_OnMuteChange(trackid, mute) end

---Sets/toggles mute-state for a MediaTrack. If MediaTrack is selected, among others, and allowgang is set to true, the new state will be set to them as well.
---@param trackid MediaTrack
---@param mute integer
---@param allowgang boolean
---@return boolean mute_state
function reaper.CSurf_OnMuteChangeEx(trackid, mute, allowgang) end

---Changes the pan-value of a track.
---@param trackid MediaTrack
---@param pan number
---@param relative boolean
---@return number pan_value
function reaper.CSurf_OnPanChange(trackid, pan, relative) end

---Changes the pan-value of a track. If MediaTrack is selected, among others, and allowgang is set to true, the new state will be set to them as well.
---@param trackid MediaTrack
---@param pan number
---@param relative boolean
---@param allowGang boolean
---@return number pan_value
function reaper.CSurf_OnPanChangeEx(trackid, pan, relative, allowGang) end

---Toggles between pause and play or when recording has started between pause and rec. Unlike CSurf_OnPlay it toggles pause first, then plays.
function reaper.CSurf_OnPause() end

---Toggles between play and pause or, when recording, rec and pause. Unlike CSurf_OnPause it toggles play first, then pauses.
function reaper.CSurf_OnPlay() end

---Sets the playbackrate of the current project. Can be between 0.25x to 4x.
---@param playrate number
function reaper.CSurf_OnPlayRateChange(playrate) end

---Sets a MediaTrack's armed state.
---@param trackid MediaTrack
---@param recarm integer
---@return boolean arm_state
function reaper.CSurf_OnRecArmChange(trackid, recarm) end

---Sets a MediaTrack's armed state. If MediaTrack is selected, among others, and allowgang is set to true, the new state will be set to them as well.
---@param trackid MediaTrack
---@param recarm integer
---@param allowgang boolean
---@return boolean arm_state
function reaper.CSurf_OnRecArmChangeEx(trackid, recarm, allowgang) end

---Toggles recording on and off. Starts recording from edit-cursor-position.
function reaper.CSurf_OnRecord() end

---Sets/alters a pan-value for a received-track. Will also change pan in the accompanying send-track!
---@param trackid MediaTrack
---@param recv_index integer
---@param pan number
---@param relative boolean
---@return number new_recv_pan_val
function reaper.CSurf_OnRecvPanChange(trackid, recv_index, pan, relative) end

---Sets/alters the volume-value of a received track. Will also change volume in the accompanying send-track!Note: You can't(!) use SLIDER2DB or DB2SLIDER for getting the volume-values, you want to set here! Use mkvolstr instead.
---@param trackid MediaTrack
---@param recv_index integer
---@param volume number
---@param relative boolean
---@return number new_recv_pan_val
function reaper.CSurf_OnRecvVolumeChange(trackid, recv_index, volume, relative) end

---Moves editcursor backward, and optionally with seekplay.
---@param seekplay integer
function reaper.CSurf_OnRew(seekplay) end

---Will move editcursor for or backward, depending on parameter dir.
---During play and whith seekplay set, the movement of the editcursor depends on the playcursor-position at the time of calling CSurf_OnRewFwd.
---@param seekplay integer
---@param dir integer
function reaper.CSurf_OnRewFwd(seekplay, dir) end

---Scroll arrangeview relative to it's current view-settings.
---@param xdir integer
---@param ydir integer
function reaper.CSurf_OnScroll(xdir, ydir) end

---Sets a track selected or not.
---@param trackid MediaTrack
---@param selected integer
---@return boolean tr_select_state
function reaper.CSurf_OnSelectedChange(trackid, selected) end

---Sets/alters the pan-volume of a send-track. Will also change the volume of the accompanying receive-track!
---@param trackid MediaTrack
---@param send_index integer
---@param pan number
---@param relative boolean
---@return number pan_value
function reaper.CSurf_OnSendPanChange(trackid, send_index, pan, relative) end

---Sets/alters the volume-value of a send-track. Will also alter the volume of the accompanying receive-track.Note: You can't(!) use SLIDER2DB or DB2SLIDER for getting the volume-values, you want to set here!
---@param trackid MediaTrack
---@param send_index integer
---@param volume number
---@param relative boolean
---@return number volume_value
function reaper.CSurf_OnSendVolumeChange(trackid, send_index, volume, relative) end

---Sets/toggles solo state of a track.
---@param trackid MediaTrack
---@param solo integer
---@return boolean solo_state
function reaper.CSurf_OnSoloChange(trackid, solo) end

---Sets/toggles solo state of a track. If MediaTrack is selected, among others, and allowgang is set to true, the new state will be set to them as well.
---@param trackid MediaTrack
---@param solo integer
---@param allowgang boolean
---@return boolean solo_state
function reaper.CSurf_OnSoloChangeEx(trackid, solo, allowgang) end

---Stops playing/recording in current project.
function reaper.CSurf_OnStop() end

---Sets the tempo of the project in beats per minute.
---@param bpm number
function reaper.CSurf_OnTempoChange(bpm) end

---@param trackid MediaTrack
function reaper.CSurf_OnTrackSelection(trackid) end

---Sets or alters volume of a track to a new value.Use DB2SLIDER to convert dB-value to fitting numbers of the volume-parameter.
---@param trackid MediaTrack
---@param volume number
---@param relative boolean
---@return number volume_value
function reaper.CSurf_OnVolumeChange(trackid, volume, relative) end

---Sets or alters volume of a track to a new value. If MediaTrack is selected, among others, and allowgang is set to true, the new state will be set to them as well.Use DB2SLIDER to convert dB-value to fitting numbers of the volume-parameter.
---@param trackid MediaTrack
---@param volume number
---@param relative boolean
---@param allowGang boolean
---@return number volume_value
function reaper.CSurf_OnVolumeChangeEx(trackid, volume, relative, allowGang) end

---Sets/alters the width-value of a track.
---@param trackid MediaTrack
---@param width number
---@param relative boolean
---@return number width_value
function reaper.CSurf_OnWidthChange(trackid, width, relative) end

---Sets/alters the width-value of a track. If MediaTrack is selected, among others, and allowgang is set to true, the new state will be set to them as well.
---@param trackid MediaTrack
---@param width number
---@param relative boolean
---@param allowGang boolean
---@return number width_value
function reaper.CSurf_OnWidthChangeEx(trackid, width, relative, allowGang) end

---Changes horizontal/vertical zoom.
---@param xdir integer
---@param ydir integer
function reaper.CSurf_OnZoom(xdir, ydir) end

---Resets all cached vol-pan-states.
function reaper.CSurf_ResetAllCachedVolPanStates() end

---Changes position of the editcursor by amt-value in seconds. When playing, the playposition changes to the editcursor-position.
---During recording, it changes only the position of the editcursor.
---@param amt number
function reaper.CSurf_ScrubAmt(amt) end

---@param mode integer
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetAutoMode(mode, ignoresurf) end

---@param play boolean
---@param pause boolean
---@param rec boolean
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetPlayState(play, pause, rec, ignoresurf) end

---@param rep boolean
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetRepeatState(rep, ignoresurf) end

---@param trackid MediaTrack
---@param mute boolean
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetSurfaceMute(trackid, mute, ignoresurf) end

---@param trackid MediaTrack
---@param pan number
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetSurfacePan(trackid, pan, ignoresurf) end

---@param trackid MediaTrack
---@param recarm boolean
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetSurfaceRecArm(trackid, recarm, ignoresurf) end

---@param trackid MediaTrack
---@param selected boolean
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetSurfaceSelected(trackid, selected, ignoresurf) end

---@param trackid MediaTrack
---@param solo boolean
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetSurfaceSolo(trackid, solo, ignoresurf) end

---@param trackid MediaTrack
---@param volume number
---@param ignoresurf IReaperControlSurface
function reaper.CSurf_SetSurfaceVolume(trackid, volume, ignoresurf) end

function reaper.CSurf_SetTrackListChange() end

---Gets a MediaTrack-object by it's number.
---@param idx integer
---@param mcpView boolean
---@return MediaTrack tr
function reaper.CSurf_TrackFromID(idx, mcpView) end

---Get the tracknumber of a MediaTrack-object.
---@param track MediaTrack
---@param mcpView boolean
---@return integer tracknumber
function reaper.CSurf_TrackToID(track, mcpView) end

---Converts dB-value into a slider-value. Good for converting envelope-point-values.
---@param x number
---@return number slider_value
function reaper.DB2SLIDER(x) end

---Delete the specific shortcut for the given command ID.
---@param section KbdSectionInfo
---@param cmdID integer
---@param shortcutidx integer
---@return boolean retval
function reaper.DeleteActionShortcut(section, cmdID, shortcutidx) end

---Delete an envelope point. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done.
---autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
---For automation items, pass autoitem_idx|0x10000000 to base ptidx on the number of points in one full loop iteration,
---even if the automation item is trimmed so that not all points are visible.
---Otherwise, ptidx will be based on the number of visible points in the automation item, including all loop iterations.
---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@param ptidx integer
---@return boolean retval
function reaper.DeleteEnvelopePointEx(envelope, autoitem_idx, ptidx) end

---Delete a range of envelope points. 
---@param envelope TrackEnvelope
---@param time_start number
---@param time_end number
---@return boolean retval
function reaper.DeleteEnvelopePointRange(envelope, time_start, time_end) end

---Delete a range of envelope points. autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@param time_start number
---@param time_end number
---@return boolean retval
function reaper.DeleteEnvelopePointRangeEx(envelope, autoitem_idx, time_start, time_end) end

---Delete the extended state value for a specific section and key. persist=true means the value should remain deleted the next time REAPER is opened. If persistent, the value will be deleted from the file reaper-extstate.ini in the ressources-folder.
---@param section string
---@param key string
---@param persist boolean
function reaper.DeleteExtState(section, key, persist) end

---Deletes a marker or a region. proj==NULL for the active project.Does not delete tempo/timesignature markers!
---@param proj ReaProject
---@param markrgnindexnumber integer
---@param isrgn boolean
---@return boolean retval
function reaper.DeleteProjectMarker(proj, markrgnindexnumber, isrgn) end

---Differs from DeleteProjectMarker only in that markrgnidx is 0 for the first marker/region in the project, 1 for the next, etc, rather than representing the displayed marker/region ID number.
---@param proj ReaProject
---@param markrgnidx integer
---@return boolean retval
function reaper.DeleteProjectMarkerByIndex(proj, markrgnidx) end

---Delete a take marker. Note that idx will change for all following take markers. 
---@param take MediaItem_Take
---@param idx integer
---@return boolean retval
function reaper.DeleteTakeMarker(take, idx) end

---Deletes one or more stretch markers. Returns number of stretch markers deleted.
---@param take MediaItem_Take
---@param idx integer
---@param countIn? integer
---@return integer count_del_stretchmarkers
function reaper.DeleteTakeStretchMarkers(take, idx, countIn) end

---Delete a tempo/time signature marker. 
---@param project ReaProject
---@param markerindex integer
---@return boolean retval
function reaper.DeleteTempoTimeSigMarker(project, markerindex) end

---deletes a track
---@param tr MediaTrack
function reaper.DeleteTrack(tr) end

---Deletes a MediaItem.
---@param tr MediaTrack
---@param it MediaItem
---@return boolean retval
function reaper.DeleteTrackMediaItem(tr, it) end

---Destroy an audio accessor. Must only call from the main thread. 
---@param accessor AudioAccessor
function reaper.DestroyAudioAccessor(accessor) end

---Open the action shortcut dialog to edit or add a shortcut for the given command ID. If (shortcutidx >= 0 && shortcutidx < CountActionShortcuts()), that specific shortcut will be replaced, otherwise a new shortcut will be added.
---@param hwnd HWND
---@param section KbdSectionInfo
---@param cmdID integer
---@param shortcutidx integer
---@return boolean retval
function reaper.DoActionShortcutDialog(hwnd, section, cmdID, shortcutidx) end

---updates preference for docker window ident_str to be in dock whichDock on next open
---@param ident_str string
---@param whichDock integer
function reaper.Dock_UpdateDockID(ident_str, whichDock) end

---returns the position of docker whichDock
---@param whichDock integer
---@return integer dock_position
function reaper.DockGetPosition(whichDock) end

---returns dock index that contains hwnd, or -1
---@param hwnd HWND
---@return integer retval, boolean isFloatingDocker
function reaper.DockIsChildOfDock(hwnd) end

---@param hwnd HWND
function reaper.DockWindowActivate(hwnd) end

---@param hwnd HWND
---@param name string
---@param pos integer
---@param allowShow boolean
function reaper.DockWindowAdd(hwnd, name, pos, allowShow) end

---@param hwnd HWND
---@param name string
---@param identstr string
---@param allowShow boolean
function reaper.DockWindowAddEx(hwnd, name, identstr, allowShow) end

---Refreshes docked windows.
function reaper.DockWindowRefresh() end

---@param hwnd HWND
function reaper.DockWindowRefreshForHWND(hwnd) end

---@param hwnd HWND
function reaper.DockWindowRemove(hwnd) end

---Open the tempo/time signature marker editor dialog.
---@param project ReaProject
---@param markerindex integer
---@return boolean retval
function reaper.EditTempoTimeSigMarker(project, markerindex) end

---call with a saved window rect for your window and it'll correct any positioning info.
---@param r.left integer
---@param r.top integer
---@param r.right integer
---@param r.bot integer
---@return integer r.left, integer r.top, integer r.right, integer r.bot
function reaper.EnsureNotCompletelyOffscreen(r.left, r.top, r.right, r.bot) end

---List the files in the "path" directory. Returns NULL/nil when all files have been listed. Use fileindex = -1 to force re-read of directory (invalidate cache). 
---@param path string
---@param fileindex integer
---@return string filename_with_path
function reaper.EnumerateFiles(path, fileindex) end

---List the subdirectories in the "path" directory. Use subdirindex = -1 to force re-read of directory (invalidate cache). Returns NULL/nil when all subdirectories have been listed. 
---@param path string
---@param subdirindex integer
---@return string filename_with_path
function reaper.EnumerateSubdirectories(path, subdirindex) end

---Start querying modes at 0, returns FALSE when no more modes possible, sets strOut to NULL if a mode is currently unsupported
---@param mode integer
---@return boolean retval, string str
function reaper.EnumPitchShiftModes(mode) end

---Returns submode name, or NULL
---@param mode integer
---@param submode integer
---@return string pitch_shift_submode
function reaper.EnumPitchShiftSubModes(mode, submode) end

---Returns the values of a given marker or region idx.
---@param idx integer
---@return integer retval, boolean isrgn, number pos, number rgnend, string name, integer markrgnindexnumber
function reaper.EnumProjectMarkers(idx) end

---Returns the values of a given marker or region idx from a given project proj.
---@param proj ReaProject
---@param idx integer
---@return integer retval, boolean isrgn, number pos, number rgnend, string name, integer markrgnindexnumber
function reaper.EnumProjectMarkers2(proj, idx) end

---Returns the values of a given marker or region idx from a given project proj.
---@param proj ReaProject
---@param idx integer
---@return integer retval, boolean isrgn, number pos, number rgnend, string name, integer markrgnindexnumber, integer color
function reaper.EnumProjectMarkers3(proj, idx) end

---Get ReaProject-object and filename of a project.
---idx=-1 for current project,projfn can be NULL if not interested in filename. use idx 0x40000000 for currently rendering project, if any.
---@param idx integer
---@return ReaProject retval, string|nil projfn
function reaper.EnumProjects(idx) end

---Enumerate the data stored with the project for a specific extname. Returns false when there is no more data.
---@param proj ReaProject
---@param extname string
---@param idx integer
---@return boolean retval, string|nil key, string|nil val
function reaper.EnumProjExtState(proj, extname, idx) end

---Enumerate which tracks will be rendered within this region when using the region render matrix. When called with rendertrack==0, the function returns the first track that will be rendered (which may be the master track); rendertrack==1 will return the next track rendered, and so on. The function returns NULL when there are no more tracks that will be rendered within this region.
---@param proj ReaProject
---@param regionindex integer
---@param rendertrack integer
---@return MediaTrack tr
function reaper.EnumRegionRenderMatrix(proj, regionindex, rendertrack) end

---returns false if there are no plugins on the track that support MIDI programs,or if all programs have been enumerated
---@param track integer
---@param programNumber integer
---@param programName string
---@return boolean retval, string programName
function reaper.EnumTrackMIDIProgramNames(track, programNumber, programName) end

---returns false if there are no plugins on the track that support MIDI programs,or if all programs have been enumerated
---@param proj ReaProject
---@param track MediaTrack
---@param programNumber integer
---@param programName string
---@return boolean retval, string programName
function reaper.EnumTrackMIDIProgramNamesEx(proj, track, programNumber, programName) end

---Get the effective envelope value at a given time position. samplesRequested is how long the caller expects until the next call to Envelope_Evaluate (often, the buffer block size). The return value is how many samples beyond that time position that the returned values are valid. dVdS is the change in value per sample (first derivative), ddVdS is the second derivative, dddVdS is the third derivative. 
---@param envelope TrackEnvelope
---@param time number
---@param samplerate number
---@param samplesRequested integer
---@return integer retval, number value, number dVdS, number ddVdS, number dddVdS
function reaper.Envelope_Evaluate(envelope, time, samplerate, samplesRequested) end

---Formats the value of an envelope to a user-readable form
---@param env TrackEnvelope
---@param value number
---@return string formatted_value
function reaper.Envelope_FormatValue(env, value) end

---If take envelope, gets the take from the envelope. If FX, indexOut set to FX index, index2Out set to parameter index, otherwise -1.
---@param env TrackEnvelope
---@return MediaItem_Take retval, integer index, integer index2
function reaper.Envelope_GetParentTake(env) end

---If track envelope, gets the track from the envelope. If FX, indexOut set to FX index, index2Out set to parameter index, otherwise -1.
---@param env TrackEnvelope
---@return MediaTrack retval, integer index, integer index2
function reaper.Envelope_GetParentTrack(env) end

---Sort envelope points by time.
---@param envelope TrackEnvelope
---@return boolean retval
function reaper.Envelope_SortPoints(envelope) end

---Sort envelope points by time. autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc. 
---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@return boolean retval
function reaper.Envelope_SortPointsEx(envelope, autoitem_idx) end

---Executes command line, returns NULL on total failure, otherwise the return value, a newline, and then the output of the command.Commands executed with ExecProcess() don't benefit from PATH-system-variables. That said, you must give the full path to a command, even if you can usually just type the command into a shell. You also may need to set a codepage manually to get the correct character-encoding. So in some cases, writing a batch-script and executing it with ExecProcess() might be a good idea.Note: when using this in Lua, you need to take care of the right file-separators: / on Mac and Linux or \ on Windows. Unlike other Lua/Lua-used-ReaScript-functions, this will not convert the file-separators to the current system's equivalent.
---Keep that in mind, when doing multi-platform-scripts!The base-directory is Reaper's appdirectory.On Windows, you can not use command-line-internal commands, like dir or cd, directly. To use them, you need to use cmd.exe. 
---You can do it like:-    "$Path_to_Command_Exe\\cmd.exe /Q /C command"where "/Q" executes cmd.exe silently(otherwise a command-line-window pops up; but output of commands will show anyway) and "/C command" executes command.To get a full directory-listing of c:\\ in a file c:\\directorylisting.txt, you can use:
----   "c:\\windows\\system32\\cmd.exe /Q /C dir c:\\ >c:\\directorylisting.txt"
---@param cmdline string
---@param timeoutmsec integer
---@return string command_output
function reaper.ExecProcess(cmdline, timeoutmsec) end

---Checks, if a specified file exists and is readable.returns true if path points to a valid, readable file
---@param path string
---@return boolean file_exists
function reaper.file_exists(path) end

---Find the tempo/time signature marker that falls at or before this time position (the marker that is in effect as of this time position).
---@param project ReaProject
---@param time number
---@return integer time_sig_marker_index
function reaper.FindTempoTimeSigMarker(project, time) end

---Creates a timestring and formats it as hh:mm:ss.sss. 
---@param tpos number
---@param buf string
---@return string formatted_time
function reaper.format_timestr(tpos, buf) end

---creates a timestring and formats with overrides and offset for a time-lengthtime formatting mode overrides: -1=proj default.
---0=time
---1=measures.beats + time
---2=measures.beats
---3=seconds
---4=samples
---5=h:m:s:f
---offset is start of where the length will be calculated from
---@param tpos number
---@param buf string
---@param offset number
---@param modeoverride integer
---@return string formatted_time
function reaper.format_timestr_len(tpos, buf, offset, modeoverride) end

---time formatting mode overrides: -1=proj default.
---    0=time
---    1=measures.beats + time
---    2=measures.beats
---    3=seconds
---    4=samples
---    5=h:m:s:f
---@param tpos number
---@param buf string
---@param modeoverride integer
---@return string formatted_time
function reaper.format_timestr_pos(tpos, buf, modeoverride) end

---Generates a GUID.
---@param gGUID string
---@return string gGUID
function reaper.genGuid(gGUID) end

---gets ini configuration variable value as stringsee the <a href="Reaper_Config_Variables.html">configuration-variable documentation</a> for more details
---@param name string
---@return boolean retval, string buf
function reaper.get_config_var_string(name) end

---Get reaper.ini full filename+path.
---@return string filename_with_path
function reaper.get_ini_file() end

---Get the text description of a specific shortcut for the given command ID.
---@param section KbdSectionInfo
---@param cmdID integer
---@param shortcutidx integer
---@return boolean retval, string desc
function reaper.GetActionShortcutDesc(section, cmdID, shortcutidx) end

---get the active take in this item
---@param item MediaItem
---@return MediaItem_Take take
function reaper.GetActiveTake(item) end

---returns the bitwise OR of all project play states, eg. and project is playing/pausing/recording (1=playing, 2=pause, 4=recording)
---@param ignoreProject ReaProject
---@return integer proj_playstates
function reaper.GetAllProjectPlayStates(ignoreProject) end

---Returns app version which may include an OS/arch signifier, such as: "6.17" (windows 32-bit), "6.17/x64" (windows 64-bit), "6.17/OSX64" (macOS 64-bit Intel), "6.17/OSX" (macOS 32-bit), "6.17/macOS-arm64", "6.17/linux-x86_64", "6.17/linux-i686", "6.17/linux-aarch64", "6.17/linux-armv7l", etc
---@return string reaper_app_version
function reaper.GetAppVersion() end

---Get the end time of the audio that can be returned from this accessor.
---@param accessor AudioAccessor
---@return number length
function reaper.GetAudioAccessorEndTime(accessor) end

---Get a short hash string (128 chars or less) that will change only if the underlying samples change.Deprecated.
---@param accessor AudioAccessor
---@param hashNeed128 string
---@return string hashNeed128
function reaper.GetAudioAccessorHash(accessor, hashNeed128) end

---Get a block of samples from the audio accessor. Samples are extracted immediately pre-FX, and returned interleaved (first sample of first channel, first sample of second channel...). Returns 0 if no audio, 1 if audio, -1 on error.This function has special handling in Python, and only returns two objects, the API function return value, and the sample buffer. Example usage:
---    <pre><code>
---            tr = RPR_GetTrack(0, 0)
---            aa = RPR_CreateTrackAudioAccessor(tr)
---            buf = list([0]*2*1024) # 2 channels, 1024 samples each, initialized to zero
---            pos = 0.0
---            (ret, buf) = GetAudioAccessorSamples(aa, 44100, 2, pos, 1024, buf)
---            # buf now holds the first 2*1024 audio samples from the track.
---            # typically GetAudioAccessorSamples() would be called within a loop, increasing pos each time.
---    </code></pre>
---@param accessor AudioAccessor
---@param samplerate integer
---@param numchannels integer
---@param starttime_sec number
---@param numsamplesperchannel integer
---@param samplebuffer reaper.array
---@return integer samples
function reaper.GetAudioAccessorSamples(accessor, samplerate, numchannels, starttime_sec, numsamplesperchannel, samplebuffer) end

---Get the start time of the audio that can be returned from this accessor.
---@param accessor AudioAccessor
---@return number audio_start_time
function reaper.GetAudioAccessorStartTime(accessor) end

---get information about the currently open audio device. 
---Attribute can be MODE, IDENT_IN, IDENT_OUT, BSIZE, SRATE, BPS. returns false if unknown attribute or device not open.
---@param attribute string
---@return boolean retval, string desc
function reaper.GetAudioDeviceInfo(attribute) end

---gets the dock ID desired by ident_str, if any
---@param ident_str string
---@return integer dock_id
function reaper.GetConfigWantsDock(ident_str) end

---returns current project if in load/save (usually only used from project_config_extension_t)
---@return ReaProject proj
function reaper.GetCurrentProjectInLoadSave() end

---return the current cursor context.
---@return integer context
function reaper.GetCursorContext() end

---0 if track panels, 1 if items, 2 if envelopes, otherwise unknown (unlikely when want_last_valid is true)
---@param want_last_valid boolean
---@return integer context
function reaper.GetCursorContext2(want_last_valid) end

---edit cursor position
---@return number position
function reaper.GetCursorPosition() end

---Get the edit cursor position in a given project
---@param proj ReaProject
---@return number position
function reaper.GetCursorPositionEx(proj) end

---gets the color of a MediaItem
---@param item MediaItem
---@return integer color
function reaper.GetDisplayedMediaItemColor(item) end

---Returns the custom take, item, or track color that is used (according to the user preference) to color the media item. The returned color is OS dependent|0x01000000 (i.e. ColorToNative(r,g,b)|0x01000000), so a return of zero means "no color", not black.
---@param item MediaItem
---@param take MediaItem_Take
---@return integer color
function reaper.GetDisplayedMediaItemColor2(item, take) end

---Gets an envelope numerical-value attribute:
---    I_TCPY : int : Y offset of envelope relative to parent track (may be separate lane or overlap with track contents)
---    I_TCPH : int : visible height of envelope
---    I_TCPY_USED : int : Y offset of envelope relative to parent track, exclusive of padding
---    I_TCPH_USED : int : visible height of envelope, exclusive of padding
---    P_TRACK : MediaTrack * : parent track pointer (if any)
---    P_DESTTRACK : MediaTrack * : destination track pointer, if on a send
---    P_ITEM : MediaItem * : parent item pointer (if any)
---    P_TAKE : MediaItem_Take * : parent take pointer (if any)
---    I_SEND_IDX : int : 1-based index of send in P_TRACK, or 0 if not a send
---    I_HWOUT_IDX : int : 1-based index of hardware output in P_TRACK or 0 if not a hardware output
---    I_RECV_IDX : int : 1-based index of receive in P_DESTTRACK or 0 if not a send/receive
---@param env TrackEnvelope
---@param parmname string
---@return number retval
function reaper.GetEnvelopeInfo_Value(env, parmname) end

---@param env TrackEnvelope
---@param buf string
---@return boolean retval, string buf
function reaper.GetEnvelopeName(env, buf) end

---Get the attributes of an envelope point.
---@param envelope TrackEnvelope
---@param ptidx integer
---@return boolean retval, number time, number value, integer shape, number tension, boolean selected
function reaper.GetEnvelopePoint(envelope, ptidx) end

---Returns the envelope point at or immediately prior to the given time position. 
---@param envelope TrackEnvelope
---@param time number
---@return integer envelope_index
function reaper.GetEnvelopePointByTime(envelope, time) end

---Returns the envelope point at or immediately prior to the given time position.
---autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
---For automation items, pass autoitem_idx|0x10000000 to base ptidx on the number of points in one full loop iteration,
---even if the automation item is trimmed so that not all points are visible.
---Otherwise, ptidx will be based on the number of visible points in the automation item, including all loop iterations.
---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@param time number
---@return integer envelope_index
function reaper.GetEnvelopePointByTimeEx(envelope, autoitem_idx, time) end

---Get the attributes of an envelope point.
---autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
---For automation items, pass autoitem_idx|0x10000000 to base ptidx on the number of points in one full loop iteration,
---even if the automation item is trimmed so that not all points are visible.
---Otherwise, ptidx will be based on the number of visible points in the automation item, including all loop iterations.
---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@param ptidx integer
---@return boolean retval, number time, number value, integer shape, number tension, boolean selected
function reaper.GetEnvelopePointEx(envelope, autoitem_idx, ptidx) end

---Returns the envelope scaling mode: 0=no scaling, 1=fader scaling. Note: All API functions deal with raw envelope point values, to convert raw from/to scaled values see ScaleFromEnvelopeMode, ScaleToEnvelopeMode.
---@param env TrackEnvelope
---@return integer scaling_mode
function reaper.GetEnvelopeScalingMode(env) end

---Gets the RPPXML state of an envelope.
---@param env TrackEnvelope
---@param str string
---@param isundo boolean
---@return boolean retval, string str
function reaper.GetEnvelopeStateChunk(env, str, isundo) end

---gets information on the UI state of an envelope: returns &1 if automation/modulation is playing back, &2 if automation is being actively written, &4 if the envelope recently had an effective automation mode change
---@param env TrackEnvelope
---@return integer retval
function reaper.GetEnvelopeUIState(env) end

---returns path of REAPER.exe (not including EXE), i.e. C:\Program Files\REAPER
---@return string path
function reaper.GetExePath() end

---Get the extended state value for a specific section and key.Note: section and key are not case-sensitive
---@param section string
---@param key string
---@return string extstate_value
function reaper.GetExtState(section, key) end

---Get focused FX. !!Deprecated, use GetFocusedFX2 insteadSee GetLastTouchedFX
---@return integer retval, integer tracknumber, integer itemnumber, integer fxnumber
function reaper.GetFocusedFX() end

---Return value has 1 set if track FX, 2 if take/item FX, &4 is set if FX is no longer focused but still open. tracknumber==0 means the master track, 1 means track 1, etc. itemnumber is zero-based (or -1 if not an item). 
---@return integer retval, number tracknumber, number itemnumber, number fxnumber
function reaper.GetFocusedFX2() end

---returns free disk space in megabytes, pathIdx 0 for normal, 1 for alternate.
---@param proj ReaProject
---@param pathidx integer
---@return integer diskspace_in_mb
function reaper.GetFreeDiskSpaceForRecordPath(proj, pathidx) end

---Returns the FX parameter envelope. If the envelope does not exist and create=true, the envelope will be created.
---@param track MediaTrack
---@param fxindex integer
---@param parameterindex integer
---@param create boolean
---@return TrackEnvelope env
function reaper.GetFXEnvelope(track, fxindex, parameterindex, create) end

---return -1=no override, 0=trim/read, 1=read, 2=touch, 3=write, 4=latch, 5=bypass
---@return integer automation_override
function reaper.GetGlobalAutomationOverride() end

---returns pixels/second
---@return number pixels_per_second
function reaper.GetHZoomLevel() end

---returns approximate input level if available, 0-511 mono inputs, |1024 for stereo pairs, 4096+devidx*32 for MIDI devices
---@param input_id integer
---@return number retval
function reaper.GetInputActivityLevel(input_id) end

---Returns the name of a input-channel.
---@param channelIndex integer
---@return string chan_name
function reaper.GetInputChannelName(channelIndex) end

---Gets the audio device input/output latency in samples
---@return number|nil retval, number outputLatency
function reaper.GetInputOutputLatency() end

---returns time of relevant edit, set which_item to the pcm_source (if applicable), flags (if specified) will be set to 1 for edge resizing, 2 for fade change, 4 for item move, 8 for item slip edit (edit cursor time or start of item)
---@return number position, PCM_source which_item, integer flags
function reaper.GetItemEditingTime2() end

---Returns the first item at the screen coordinates specified. If allow_locked is false, locked items are ignored. If takeOutOptional specified, returns the take hit(in Lua, this function simply returns the take as additional return-value).Note: You can not get the item at screen-coordinates, where it is hidden by other windows.
---@param screen_x integer
---@param screen_y integer
---@param allow_locked boolean
---@return MediaItem item, MediaItem_Take take
function reaper.GetItemFromPoint(screen_x, screen_y, allow_locked) end

---Returns the project, in which a MediaItem is located.
---@param item MediaItem
---@return ReaProject proj
function reaper.GetItemProjectContext(item) end

---Gets the RPPXML state of an item, returns true if successful. Undo flag is a performance/caching hint.
---@param item MediaItem
---@param str string
---@param isundo boolean
---@return boolean retval, string str
function reaper.GetItemStateChunk(item, str, isundo) end

---Get the last used color-theme-file.
---@return string theme_filename_with_path
function reaper.GetLastColorThemeFile() end

---Get the last project marker before time, and/or the project region that includes time. 
---markeridx and regionidx are returned not necessarily as the displayed marker/region index, but as the index that can be passed to EnumProjectMarkers. Either or both of markeridx and regionidx may be NULL. 
---@param proj ReaProject
---@param time number
---@return integer|nil retval, integer regionidx
function reaper.GetLastMarkerAndCurRegion(proj, time) end

---Returns the last touched track, it's last touched parameter and tracknumber.The low word of tracknumber is the 1-based track index -- 0 means the master track, 1 means track 1, etc. 
---@return boolean retval, integer tracknumber, integer fxnumber, integer paramnumber
function reaper.GetLastTouchedFX() end

---Gets the MediaTrack, that has been last touched.
---@return MediaTrack tr
function reaper.GetLastTouchedTrack() end

---Get the Reaper-window as an HWND-object
---@return HWND hwnd
function reaper.GetMainHwnd() end

---Deprecated: Get the mute/solo-state of the master-track. This is deprecated as you can just query the master track as well.
---@return integer mastermutesolo
function reaper.GetMasterMuteSoloFlags() end

---Get a MediaTrack-object of the MasterTrack.
---@param proj ReaProject
---@return MediaTrack track
function reaper.GetMasterTrack(proj) end

---Get the visibility of the master-track in mixer and track-control-panel.
---@return integer master_visibility
function reaper.GetMasterTrackVisibility() end

---returns max dev for midi inputs
---@return integer max_midi_inputs
function reaper.GetMaxMidiInputs() end

---returns max dev for midi outputs
---@return integer max_midi_outputs
function reaper.GetMaxMidiOutputs() end

---Get text-based metadata from a media file for a given identifier. Call with identifier="" to list all identifiers contained in the file, separated by newlines. May return "[Binary data]" for metadata that REAPER doesn't handle.
---@param mediaSource PCM_source
---@param identifier string
---@return integer retval, string buf
function reaper.GetMediaFileMetadata(mediaSource, identifier) end

---get an item from a project by item count (zero-based)
---@param proj ReaProject
---@param itemidx integer
---@return MediaItem item
function reaper.GetMediaItem(proj, itemidx) end

---Get parent track of media item
---@param item MediaItem
---@return MediaTrack track
function reaper.GetMediaItem_Track(item) end

---gets the currently armed command and section name (returns 0 if nothing armed). section name is empty-string for main section.
---@return integer retval, string sec
function reaper.GetArmedCommand() end

---arms a command (or disarms if 0 passed) in section sectionname (empty string for main)
---@param cmd integer
---@param sectionname string
function reaper.ArmCommand(cmd, sectionname) end

---Get media item numerical-value attributes.
---    B_MUTE : bool * : muted (item solo overrides). setting this value will clear C_MUTE_SOLO.
---    B_MUTE_ACTUAL : bool * : muted (ignores solo). setting this value will not affect C_MUTE_SOLO.
---    C_MUTE_SOLO : char * : solo override (-1=soloed, 0=no override, 1=unsoloed). note that this API does not automatically unsolo other items when soloing (nor clear the unsolos when clearing the last soloed item), it must be done by the caller via action or via this API.
---    B_LOOPSRC : bool * : loop source
---    B_ALLTAKESPLAY : bool * : all takes play
---    B_UISEL : bool * : selected in arrange view
---    C_BEATATTACHMODE : char * : item timebase, -1=track or project default, 1=beats (position, length, rate), 2=beats (position only). for auto-stretch timebase: C_BEATATTACHMODE=1, C_AUTOSTRETCH=1
---    C_AUTOSTRETCH: : char * : auto-stretch at project tempo changes, 1=enabled, requires C_BEATATTACHMODE=1
---    C_LOCK : char * : locked, &1=locked, &2=lock to active take
---    D_VOL : double * : item volume, 0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc
---    D_POSITION : double * : item position in seconds
---    D_LENGTH : double * : item length in seconds
---    D_SNAPOFFSET : double * : item snap offset in seconds
---    D_FADEINLEN : double * : item manual fadein length in seconds
---    D_FADEOUTLEN : double * : item manual fadeout length in seconds
---    D_FADEINDIR : double * : item fadein curvature, -1..1
---    D_FADEOUTDIR : double * : item fadeout curvature, -1..1
---    D_FADEINLEN_AUTO : double * : item auto-fadein length in seconds, -1=no auto-fadein
---    D_FADEOUTLEN_AUTO : double * : item auto-fadeout length in seconds, -1=no auto-fadeout
---    C_FADEINSHAPE : int * : fadein shape, 0..6, 0=linear
---    C_FADEOUTSHAPE : int * : fadeout shape, 0..6, 0=linear
---    I_GROUPID : int * : group ID, 0=no group
---    I_LASTY : int * : Y-position (relative to top of track) in pixels (read-only)
---    I_LASTH : int * : height in pixels (read-only)
---    I_CUSTOMCOLOR : int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). If you do not |0x1000000, then it will not be used, but will store the color
---    I_CURTAKE : int * : active take number
---    IP_ITEMNUMBER : int : item number on this track (read-only, returns the item number directly)
---    F_FREEMODE_Y : float * : free item positioning Y-position, 0=top of track, 1=bottom of track (will never be 1)
---    F_FREEMODE_H : float * : free item positioning height, 0=no height, 1=full height of track (will never be 0)
---    P_TRACK : MediaTrack * : (read-only)
---@param item MediaItem
---@param parmname string
---@return number retval
function reaper.GetMediaItemInfo_Value(item, parmname) end

---Get the number of takes in a MediaItem-object.
---@param item MediaItem
---@return integer itemnumtakes
function reaper.GetMediaItemNumTakes(item) end

---Get a take from a MediaItem as a MediaItem_Take-object.
---@param item MediaItem
---@param tk integer
---@return MediaItem_Take take
function reaper.GetMediaItemTake(item, tk) end

---Get parent item of media item take.
---@param take MediaItem_Take
---@return MediaItem item
function reaper.GetMediaItemTake_Item(take) end

---Gets block of peak samples to buf. Note that the peak samples are interleaved, but in two or three blocks (maximums, then minimums, then extra). Return value has 20 bits of returned sample count, then 4 bits of output_mode (0xf00000), then a bit to signify whether extra_type was available (0x1000000). extra_type can be 115 ('s') for spectral information, which will return peak samples as integers with the low 15 bits frequency, next 14 bits tonality.
---peakrate is number of pixels in seconds.
---@param take MediaItem_Take
---@param peakrate number
---@param starttime number
---@param numchannels integer
---@param numsamplesperchannel integer
---@param want_extra_type integer
---@param buf reaper.array
---@return integer peaks
function reaper.GetMediaItemTake_Peaks(take, peakrate, starttime, numchannels, numsamplesperchannel, want_extra_type, buf) end

---Get media source of media item take
---@param take MediaItem_Take
---@return PCM_source source
function reaper.GetMediaItemTake_Source(take) end

---Get parent track of media item take
---@param take MediaItem_Take
---@return MediaTrack track
function reaper.GetMediaItemTake_Track(take) end

---@param project ReaProject
---@param guidGUID string
---@return MediaItem_Take take
function reaper.GetMediaItemTakeByGUID(project, guidGUID) end

---Get media item take numerical-value attributes.
---D_STARTOFFS : double * : start offset in source media, in seconds
---D_VOL : double * : take volume, 0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc, negative if take polarity is flipped
---D_PAN : double * : take pan, -1..1
---D_PANLAW : double * : take pan law, -1=default, 0.5=-6dB, 1.0=+0dB, etc
---D_PLAYRATE : double * : take playback rate, 0.5=half speed, 1=normal, 2=double speed, etc
---D_PITCH : double * : take pitch adjustment in semitones, -12=one octave down, 0=normal, +12=one octave up, etc
---B_PPITCH : bool * : preserve pitch when changing playback rate
---I_LASTY : int * : Y-position (relative to top of track) in pixels (read-only)
---I_LASTH : int * : height in pixels (read-only)
---I_CHANMODE : int * : channel mode, 0=normal, 1=reverse stereo, 2=downmix, 3=left, 4=right
---I_PITCHMODE : int * : pitch shifter mode, -1=projext default, otherwise high 2 bytes=shifter, low 2 bytes=parameter
---I_CUSTOMCOLOR : int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). If you do not |0x1000000, then it will not be used, but will store the color.
---IP_TAKENUMBER : int : take number (read-only, returns the take number directly)
---P_TRACK : pointer to MediaTrack (read-only)
---P_ITEM : pointer to MediaItem (read-only)
---P_SOURCE : PCM_source *. Note that if setting this, you should first retrieve the old source, set the new, THEN delete the old.
---@param take MediaItem_Take
---@param parmname string
---@return number retval
function reaper.GetMediaItemTakeInfo_Value(take, parmname) end

---Get the associated MediaTrack of a MediaItem.
---@param item MediaItem
---@return MediaTrack tr
function reaper.GetMediaItemTrack(item) end

---Copies the media source filename to filenamebuf. Note that in-project MIDI media sources have no associated filename. 
---@param source PCM_source
---@return string filenamebuf
function reaper.GetMediaSourceFileName(source) end

---Returns the length of the source media. If the media source is beat-based, the length will be in quarter notes, otherwise it will be in seconds.
---@param source PCM_source
---@return number retval, boolean lengthIsQN
function reaper.GetMediaSourceLength(source) end

---Returns the number of channels in the source media.
---@param source PCM_source
---@return integer mediasourcenumchans
function reaper.GetMediaSourceNumChannels(source) end

---Returns the parent source, or NULL if src is the root source. This can be used to retrieve the parent properties of sections or reversed sources for example.
---@param src PCM_source
---@return PCM_source parent_src
function reaper.GetMediaSourceParent(src) end

---Returns the sample rate. MIDI source media will return zero.
---@param source PCM_source
---@return integer mediasourcesamplerate
function reaper.GetMediaSourceSampleRate(source) end

---copies the media source type ("WAV", "MIDI", etc) to typebuf
---@param source PCM_source
---@return string typebuf
function reaper.GetMediaSourceType(source) end

---Get track numerical-value attributes.
---B_MUTE : bool * : muted
---B_PHASE : bool * : track phase inverted
---B_RECMON_IN_EFFECT : bool * : record monitoring in effect (current audio-thread playback state, read-only)
---IP_TRACKNUMBER : int : track number 1-based, 0=not found, -1=master track (read-only, returns the int directly)
---I_SOLO : int * : soloed, 0=not soloed, 1=soloed, 2=soloed in place, 5=safe soloed, 6=safe soloed in place
---B_SOLO_DEFEAT : bool * : when set, if anything else is soloed and this track is not muted, this track acts soloed
---I_FXEN : int * : fx enabled, 0=bypassed, !0=fx active
---I_RECARM : int * : record armed, 0=not record armed, 1=record armed
---I_RECINPUT : int * : record input, <0=no input. if 4096 set, input is MIDI and low 5 bits represent channel (0=all, 1-16=only chan), next 6 bits represent physical input (63=all, 62=VKB). If 4096 is not set, low 10 bits (0..1023) are input start channel (ReaRoute/Loopback start at 512). If 2048 is set, input is multichannel input (using track channel count), or if 1024 is set, input is stereo input, otherwise input is mono.
---I_RECMODE : int * : record mode, 0=input, 1=stereo out, 2=none, 3=stereo out w/latency compensation, 4=midi output, 5=mono out, 6=mono out w/ latency compensation, 7=midi overdub, 8=midi replace
---I_RECMODE_FLAGS : int * : record mode flags, &3=output recording mode (0=post fader, 1=pre-fx, 2=post-fx/pre-fader)
---I_RECMON : int * : record monitoring, 0=off, 1=normal, 2=not when playing (tape style)
---I_RECMONITEMS : int * : monitor items while recording, 0=off, 1=on
---B_AUTO_RECARM : bool * : automatically set record arm when selected (does not immediately affect recarm state, script should set directly if desired)
---I_VUMODE : int * : track vu mode, &1:disabled, &30==0:stereo peaks, &30==2:multichannel peaks, &30==4:stereo RMS, &30==8:combined RMS, &30==12:LUFS-M, &30==16:LUFS-S (readout=max), &30==20:LUFS-S (readout=current), &32:LUFS calculation on channels 1+2 only            
---I_AUTOMODE : int * : track automation mode, 0=trim/off, 1=read, 2=touch, 3=write, 4=latch
---I_NCHAN : int * : number of track channels, 2-64, even numbers only
---I_SELECTED : int * : track selected, 0=unselected, 1=selected
---I_WNDH : int * : current TCP window height in pixels including envelopes (read-only)
---I_TCPH : int * : current TCP window height in pixels not including envelopes (read-only)
---I_TCPY : int * : current TCP window Y-position in pixels relative to top of arrange view (read-only)
---I_MCPX : int * : current MCP X-position in pixels relative to mixer container(read only)
---I_MCPY : int * : current MCP Y-position in pixels relative to mixer container(read only)
---I_MCPW : int * : current MCP width in pixels(read only)
---I_MCPH : int * : current MCP height in pixels(read only)
---I_FOLDERDEPTH : int * : folder depth change, 0=normal, 1=track is a folder parent, -1=track is the last in the innermost folder, -2=track is the last in the innermost and next-innermost folders, etc
---I_FOLDERCOMPACT : int * : folder compacted state (only valid on folders), 0=normal, 1=small, 2=tiny children
---I_MIDIHWOUT : int * : track midi hardware output index, <0=disabled, low 5 bits are which channels (0=all, 1-16), next 5 bits are output device index (0-31)
---I_PERFFLAGS : int * : track performance flags, &1=no media buffering, &2=no anticipative FX
---I_CUSTOMCOLOR : int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000), 0, default color. If you do not |0x1000000, then it will not be used, but will store the color.
---I_HEIGHTOVERRIDE : int * : custom height override for TCP window, 0 for none, otherwise size in pixels
---B_HEIGHTLOCK : bool * : track height lock (must set I_HEIGHTOVERRIDE before locking)
---D_VOL : double * : trim volume of track, 0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc
---D_PAN : double * : trim pan of track, -1..1
---D_WIDTH : double * : width of track, -1..1
---D_DUALPANL : double * : dualpan position 1, -1..1, only if I_PANMODE==6
---D_DUALPANR : double * : dualpan position 2, -1..1, only if I_PANMODE==6
---I_PANMODE : int * : pan mode, 0=classic 3.x, 3=new balance, 5=stereo pan, 6=dual pan
---D_PANLAW : double * : pan law of track, <0=project default, 0.5=-6dB, 0.707..=-3dB, 1=+0dB, 1.414..=-3dB with gain compensation, 2=-6dB with gain compensation, etc
---I_PANLAW_FLAGS : int * : pan law flags, 0=sine taper, 1=hybrid taper with deprecated behavior when gain compensation enabled, 2=linear taper, 3=hybrid taper
---P_ENV:&envchunkname or P_ENV:{GUID... : TrackEnvelope * : (read-only) chunkname can be &VOLENV, &PANENV, etc; GUID is the stringified envelope GUID
---B_SHOWINMIXER : bool * : track control panel visible in mixer (do not use on master track)
---B_SHOWINTCP : bool * : track control panel visible in arrange view (do not use on master track)
---B_MAINSEND : bool * : track sends audio to parent
---C_MAINSEND_OFFS : char * : channel offset of track send to parent
---C_MAINSEND_NCH : char * : channel count of track send to parent (0=use all child track channels, 1=use one channel only)
---I_FREEMODE : int * : 1=track free item positioning enabled, 2=track fixed lanes enabled (call UpdateTimeline() after changing)
---C_BEATATTACHMODE : char * : track timebase, -1=project default, 0=time, 1=beats (position, length, rate), 2=beats (position only)
---F_MCP_FXSEND_SCALE : float * : scale of fx+send area in MCP (0=minimum allowed, 1=maximum allowed)
---F_MCP_FXPARM_SCALE : float * : scale of fx parameter area in MCP (0=minimum allowed, 1=maximum allowed)
---F_MCP_SENDRGN_SCALE : float * : scale of send area as proportion of the fx+send total area (0=minimum allowed, 1=maximum allowed)
---F_TCP_FXPARM_SCALE : float * : scale of TCP parameter area when TCP FX are embedded (0=min allowed, default, 1=max allowed)
---I_PLAY_OFFSET_FLAG : int * : track media playback offset state, &1=bypassed, &2=offset value is measured in samples (otherwise measured in seconds)
---D_PLAY_OFFSET : double * : track media playback offset, units depend on I_PLAY_OFFSET_FLAG
---P_PARTRACK : MediaTrack * : parent track (read-only)
---P_PROJECT : ReaProject * : parent project (read-only)
---@param tr MediaTrack
---@param parmname string
---@return number retval
function reaper.GetMediaTrackInfo_Value(tr, parmname) end

---returns true if device present
---@param dev integer
---@param nameout string
---@return boolean retval, string nameout
function reaper.GetMIDIInputName(dev, nameout) end

---returns true if device present
---@param dev integer
---@param nameout string
---@return boolean retval, string nameout
function reaper.GetMIDIOutputName(dev, nameout) end

---Get the leftmost track visible in the mixer
---@return MediaTrack leftmosttrack
function reaper.GetMixerScroll() end

---Get the current mouse modifier assignment for a specific modifier key assignment, in a specific context.
---action will be filled in with the command ID number for a built-in mouse modifier
---or built-in REAPER command ID, or the custom action ID string.
---@param context string
---@param modifier_flag integer
---@return string action
function reaper.GetMouseModifier(context, modifier_flag) end

---get mouse position in screen coordinates
---@return integer x, integer y
function reaper.GetMousePosition() end

---Return number of normal audio hardware inputs available
---@return integer numAudioIns
function reaper.GetNumAudioInputs() end

---Return number of normal audio hardware outputs available
---@return integer numAudioOuts
function reaper.GetNumAudioOutputs() end

---returns max number of real midi hardware inputs
---@return integer numMidiIns
function reaper.GetNumMIDIInputs() end

---returns max number of real midi hardware outputs
---@return integer numMidiOuts
function reaper.GetNumMIDIOutputs() end

---Returns number of take markers.
---@param take MediaItem_Take
---@return integer retval
function reaper.GetNumTakeMarkers(take) end

---Get the number of tracks. Excluding the master-track.
---@return integer numtracks
function reaper.GetNumTracks() end

---Returns the current operating-system. Good for determining, e.g. the correct filesystem-separators.
---@return string operating_system
function reaper.GetOS() end

---Get the name of a specific output-channel.
---@param channelIndex integer
---@return string outputchanname
function reaper.GetOutputChannelName(channelIndex) end

---returns output latency in seconds
---@return number outputlatency
function reaper.GetOutputLatency() end

---Get the parent MediaTrack, if a MediaTrack is a track of a foldered track.
---@param track MediaTrack
---@return MediaTrack parenttrack
function reaper.GetParentTrack(track) end

---get the peak file name for a given file (can be either filename.reapeaks,or a hashed filename in another path)
---@param fn string
---@return string peakfilename_with_path
function reaper.GetPeakFileName(fn) end

---get the peak file name for a given file (can be either filename.reapeaks,or a hashed filename in another path)
---@param fn string
---@param buf string
---@param forWrite boolean
---@return string buf
function reaper.GetPeakFileNameEx(fn, buf, forWrite) end

---Like GetPeakFileNameEx, but you can specify peaksfileextension such as ".reapeaks"
---@param fn string
---@param buf string
---@param forWrite boolean
---@param peaksfileextension string
---@return string buf
function reaper.GetPeakFileNameEx2(fn, buf, forWrite, peaksfileextension) end

---returns latency-compensated actual-what-you-hear position
---@return number playposition
function reaper.GetPlayPosition() end

---returns position of next audio block being processed
---@return number playposition
function reaper.GetPlayPosition2() end

---returns position of next audio block being processed from a specific project
---@param proj ReaProject
---@return number playposition
function reaper.GetPlayPosition2Ex(proj) end

---returns latency-compensated actual-what-you-hear position from a specific project
---@param proj ReaProject
---@return number playposition
function reaper.GetPlayPositionEx(proj) end

---returns, in which play-state the current project is
---@return integer playstate
function reaper.GetPlayState() end

---returns, in which play-state a certain project is
---@param proj ReaProject
---@return integer playstate
function reaper.GetPlayStateEx(proj) end

---returns length of project (maximum of end of media item, markers, end of regions, tempo map)
---@param proj ReaProject
---@return number length
function reaper.GetProjectLength(proj) end

---Get the name of the projectfile.
---@param proj ReaProject
---@return string projectname
function reaper.GetProjectName(proj) end

---Get the path of the project. Will return the defaults project-path's recording-folder, when the project hasn't been saved yet; when the project has been saved, it will return the path to the recording-folder.If you need the filename of the path+projectfile itself, use EnumProjects instead.
---@return string project_path
function reaper.GetProjectPath() end

---Get the path of a specific project, usually the recordings-folder.
---@param proj ReaProject
---@return string project_path
function reaper.GetProjectPathEx(proj) end

---returns an integer that changes when the project state changes, e.g. undoable-actions have been made.
---@param proj ReaProject
---@return integer count_statechange
function reaper.GetProjectStateChangeCount(proj) end

---Gets project time offset in seconds (project settings -> project start time). 
---@param proj ReaProject
---@param rndframe boolean
---@return number time_offset
function reaper.GetProjectTimeOffset(proj, rndframe) end

---deprecated
---@return number bpm, number bpi
function reaper.GetProjectTimeSignature() end

---Gets basic time signature (beats per minute, numerator of time signature in bpi)
---this does not reflect tempo envelopes but is purely what is set in the project settings.
---@param proj ReaProject
---@return number bpm, number bpi
function reaper.GetProjectTimeSignature2(proj) end

---Get the value previously associated with this extname and key, the last time the project was saved or the value was changed.
---@param proj ReaProject
---@param extname string
---@param key string
---@return integer retval, string val
function reaper.GetProjExtState(proj, extname, key) end

---returns path where ini files are stored, other things are in subdirectories.When resourcepath is equal to app-path(see GetExePath), it is an indicator that Reaper is installed as portable installation.
---@return string resource_path
function reaper.GetResourcePath() end

---get the currently selected envelope, returns NULL/nil if no envelope is selected
---@param proj ReaProject
---@return TrackEnvelope env
function reaper.GetSelectedEnvelope(proj) end

---get a selected item by selected item count (zero-based)
---@param proj ReaProject
---@param selitem integer
---@return MediaItem sel_item
function reaper.GetSelectedMediaItem(proj, selitem) end

---Get a selected track from a project by selected track count (zero-based). 
---This function ignores the master track, see GetSelectedTrack2 and CountSelectedTracks.
---@param proj ReaProject
---@param seltrackidx integer
---@return MediaTrack sel_tr
function reaper.GetSelectedTrack(proj, seltrackidx) end

---Get a selected track from a project (proj=0 for active project) by selected track count (zero-based).
---@param proj ReaProject
---@param seltrackidx integer
---@param wantmaster boolean
---@return MediaTrack sel_tr
function reaper.GetSelectedTrack2(proj, seltrackidx, wantmaster) end

---get the currently selected track envelope, returns NULL/nil if no envelope is selected
---@param proj ReaProject
---@return TrackEnvelope sel_env
function reaper.GetSelectedTrackEnvelope(proj) end

---Gets or sets the arrange view start/end time for screen coordinates. use screen_x_start=screen_x_end=0 to use the full arrange view's start/end timeIf you want to get the arrangeviewposition by pixels, set isSet=false and pass the pixel-position of the start and endposition to screen_x_start and screen_x_end.screen_x_start and screen_x_end will be ignored, when isSet=true
---@param proj ReaProject
---@param isSet boolean
---@param screen_x_start integer
---@param screen_x_end integer
---@param start_time number
---@param end_time number
---@return number start_time, number end_time
function reaper.GetSet_ArrangeView2(proj, isSet, screen_x_start, screen_x_end, start_time, end_time) end

---Gets/sets a time-selection/loop.Loops and time-selections can be unlinked in preferences -> Editing Behavior -> Link loops to time selection.
---So you can control them individually, when you've unlinked them with this function.
---
---@param isSet boolean
---@param isLoop boolean
---@param start_sel number
---@param end_sel number
---@param allowautoseek boolean
---@return number start_sel, number end_sel
function reaper.GetSet_LoopTimeRange(isSet, isLoop, start_sel, end_sel, allowautoseek) end

---Gets/sets a time-selection/loop.Loops and time-selections can be unlinked in preferences -> Editing Behavior -> Link loops to time selection.
---So you can control them individually, when you've unlinked them with this function.
---
---@param proj ReaProject
---@param isSet boolean
---@param isLoop boolean
---@param start_sel number
---@param end_sel number
---@param allowautoseek boolean
---@return number start_sel, number end_sel
function reaper.GetSet_LoopTimeRange2(proj, isSet, isLoop, start_sel, end_sel, allowautoseek) end

---Get or set automation item information. autoitem_idx=0 for the first automation item on an envelope, 1 for the second item, etc. desc can be any of the following:
---D_POOL_ID : double * : automation item pool ID (as an integer); edits are propagated to all other automation items that share a pool ID
---D_POSITION : double * : automation item timeline position in seconds
---D_LENGTH : double * : automation item length in seconds
---D_STARTOFFS : double * : automation item start offset in seconds
---D_PLAYRATE : double * : automation item playback rate
---D_BASELINE : double * : automation item baseline value in the range [0,1]
---D_AMPLITUDE : double * : automation item amplitude in the range [-1,1]
---D_LOOPSRC : double * : nonzero if the automation item contents are looped
---D_UISEL : double * : nonzero if the automation item is selected in the arrange view
---D_POOL_QNLEN : double * : automation item pooled source length in quarter notes (setting will affect all pooled instances)
---@param env TrackEnvelope
---@param autoitem_idx integer
---@param desc string
---@param value number
---@param is_set boolean
---@return number retval
function reaper.GetSetAutomationItemInfo(env, autoitem_idx, desc, value, is_set) end

---Get or set automation item information. autoitem_idx=0 for the first automation item on an envelope, 1 for the second item, etc. returns true on success. desc can be any of the following:P_POOL_NAME : char * : name of the underlying automation item pool
---P_POOL_EXT:xyz : char * : extension-specific persistent data
---@param env TrackEnvelope
---@param autoitem_idx integer
---@param desc string
---@param valuestrNeedBig string
---@param is_set boolean
---@return boolean retval, string valuestrNeedBig
function reaper.GetSetAutomationItemInfo_String(env, autoitem_idx, desc, valuestrNeedBig, is_set) end

---Gets/sets an attribute string:
---P_EXT:xyz : char * : extension-specific persistent data
---GUID : GUID * : 16-byte GUID, can query only, not set. If using a _String() function, GUID is a string {xyz-...}.This is basically a key-value-store for envelopes.
---@param env TrackEnvelope
---@param parmname_attribute string
---@param valueStringNeedBig string
---@param setNewValue boolean
---@return boolean retval, string stringNeedBig
function reaper.GetSetEnvelopeInfo_String(env, parmname_attribute, valueStringNeedBig, setNewValue) end

---deprecated -- see SetEnvelopeStateChunk, GetEnvelopeStateChunk
---@param env TrackEnvelope
---@param str string
---@return boolean retval, string str
function reaper.GetSetEnvelopeState(env, str) end

---deprecated -- see SetEnvelopeStateChunk, GetEnvelopeStateChunk
---@param env TrackEnvelope
---@param str string
---@param isundo boolean
---@return boolean retval, string str
function reaper.GetSetEnvelopeState2(env, str, isundo) end

---deprecated -- see SetItemStateChunk, GetItemStateChunk
---@param item MediaItem
---@param str string
---@return boolean retval, string str
function reaper.GetSetItemState(item, str) end

---deprecated -- see SetItemStateChunk, GetItemStateChunk
---@param item MediaItem
---@param str string
---@param isundo boolean
---@return boolean retval, string str
function reaper.GetSetItemState2(item, str, isundo) end

---Gets/sets an item attribute string:
---    P_NOTES : char * : item note text (do not write to returned pointer, use setNewValue to update)
---    P_EXT:xyz : char * : extension-specific persistent data
---    GUID : GUID * : 16-byte GUID, can query or update. If using a _String() function, GUID is a string {xyz-...}.
---@param item MediaItem
---@param parmname string
---@param stringNeedBig string
---@param setNewValue boolean
---@return boolean retval, string stringNeedBig
function reaper.GetSetMediaItemInfo_String(item, parmname, stringNeedBig, setNewValue) end

---Gets/sets a take attribute string:
---    P_NAME : char * : take name
---    P_EXT:xyz : char * : extension-specific persistent data
---    GUID : GUID * : 16-byte GUID, can query or update. If using a _String() function, GUID is a string {xyz-...}.
---@param tk MediaItem_Take
---@param parmname string
---@param stringNeedBig string
---@param setnewvalue boolean
---@return boolean retval, string stringNeedBig
function reaper.GetSetMediaItemTakeInfo_String(tk, parmname, stringNeedBig, setnewvalue) end

---Get or set track string attributes.
---P_NAME : char * : track name (on master returns NULL)
---P_ICON : const char * : track icon (full filename, or relative to resource_path/data/track_icons)
---P_MCP_LAYOUT : const char * : layout name
---P_RAZOREDITS : const char * : list of razor edit areas, as space-separated triples of start time, end time, and envelope GUID string.
---    Passing the guid sets selection within the envelope; not passing the guid sets the selection within the track itself.
---    Example: "0.00 1.00 \"\" 0.00 1.00 "{xyz-...}"
---    Set stringNeedBig="" and setnewvalue=false to query the currently set razor-edits on this track.
---P_RAZOREDITS_EXT : const char * : list of razor edit areas, as comma-separated sets of space-separated tuples of start time, end time, optional envelope GUID string, optional fixed/fipm top y-position, optional fixed/fipm bottom y-position(fipm means fixed item positioning).
---    Example: "0.0 1.0,0.0 1.0 "{xyz-...}",1.0 2.0 "" 0.25 0.5"
---    see P_RAZOREDITS above for more details
---P_TCP_LAYOUT : const char * : layout name
---P_EXT:xyz : char * : extension-specific persistent data
---P_UI_RECT:tcp.mute : char * : read-only, allows querying screen position + size of track WALTER elements (tcp.size queries screen position and size of entire TCP, etc).
---GUID : GUID * : 16-byte GUID, can query or update. If using a _String() function, GUID is a string {xyz-...}.
---@param tr MediaTrack
---@param parmname string
---@param stringNeedBig string
---@param setnewvalue boolean
---@return boolean retval, string stringNeedBig
function reaper.GetSetMediaTrackInfo_String(tr, parmname, stringNeedBig, setnewvalue) end

---deprecated, see GetSetProjectInfo_String with desc="PROJECT_AUTHOR"
---@param proj ReaProject
---@param set boolean
---@param author string
---@return string author
function reaper.GetSetProjectAuthor(proj, set, author) end

---Get or set the arrange view grid division. 0.25=quarter note, 1.0/3.0=half note triplet, etc. swingmode can be 1 for swing enabled, swingamt is -1..1. swingmode can be 3 for measure-grid. Returns grid configuration flags
---@param project ReaProject
---@param set boolean
---@param division? number
---@param swingmode? integer
---@param swingamt? number
---@return integer retval, number|nil division, integer|nil swingmode, number|nil swingamt
function reaper.GetSetProjectGrid(project, set, division, swingmode, swingamt) end

---Get or set project information.
--- 
---RENDER_SETTINGS : 
---    &(1|2)=0:master mix, 
---    &1=stems+master mix, 
---    &2=stems only, 
---    &4=multichannel tracks to multichannel files, 
---    &8=use render matrix, 
---    &16=tracks with only mono media to mono files, 
---    &32=selected media items, 
---    &64=selected media items via master, 
---    &128=Selected tracks via master, 
---    &256=Stretch markers/transient guide-checkbox(Only with WAV/AIFF and Source=Selected media items/Selected media items via master), 
---    &512=Embed Metadata, if format supports is, 
---    &1024=Take markers-checkbox(Only with WAV and Source=Selected media items/Selected media items via master); 
---    &2048=2nd pass render  
---OGG, OPUS and FLAC support embedding of tempoinformation via metadata, settable using GetSetProjectInfo_String.  
---RENDER_BOUNDSFLAG : 
---  0=custom time bounds, 
---  1=entire project, 
---  2=time selection, 
---  3=all project regions, 
---  4=selected media items, 
---  5=selected project regions, 
---  6=all project markers, 
---  7=selected project markers
---RENDER_CHANNELS : number of channels in rendered file  
---RENDER_SRATE : sample rate of rendered file (or 0 for project sample rate)  
---RENDER_STARTPOS : render start time when RENDER_BOUNDSFLAG=0  
---RENDER_ENDPOS : render end time when RENDER_BOUNDSFLAG=0  
---RENDER_TAILFLAG : apply render tail setting when rendering: 
---  &1=custom time bounds, 
---  &2=entire project, 
---  &4=time selection, 
---  &8=all project markers/regions, 
---  &16=selected media items, 
---  &32=selected project markers/regions
---RENDER_TAILMS : tail length in ms to render (only used if RENDER_BOUNDSFLAG and RENDER_TAILFLAG are set)  
---RENDER_ADDTOPROJ : 
---  &1=add rendered files to project, 
---  &2=Do not render files that are likely silent  
---RENDER_DITHER : 
---  &1=dither, 
---  &2=noise shaping, 
---  &4=dither stems, 
---  &8=noise shaping on stems  
---RENDER_NORMALIZE: 
---  &1=enable, (&14==0)=LUFS-I, (&14==2)=RMS, (&14==4)=peak, (&14==6)=true peak, (&14==8)=LUFS-M max, (&14==10)=LUFS-S max, 
---  &32=normalize stems to common gain based on master, 
---  &64=enable brickwall limit, 
---  &128=brickwall limit true peak, 
---  &256=only normalize files that are too loud, 
---  &512=apply fade-in, 
---  &1024=apply fade-out
---RENDER_NORMALIZE_TARGET: render normalization target as amplitude, so 0.5 means -6.02dB, 0.25 means -12.04dB, etc  
---RENDER_BRICKWALL: render brickwall limit as amplitude, so 0.5 means -6.02dB, 0.25 means -12.04dB, etc
---RENDER_FADEIN: render fade-in (0.001 means 1 ms, requires RENDER_NORMALIZE&512)
---RENDER_FADEOUT: render fade-out (0.001 means 1 ms, requires RENDER_NORMALIZE&1024)
---RENDER_FADEINSHAPE: render fade-in shape
---RENDER_FADEOUTSHAPE: render fade-out shape
---PROJECT_SRATE : samplerate (ignored unless PROJECT_SRATE_USE set)  
---PROJECT_SRATE_USE : set to 1 if project samplerate is used  
---@param project ReaProject
---@param desc string
---@param value number
---@param is_set boolean
---@return number value
function reaper.GetSetProjectInfo(project, desc, value, is_set) end

---Get or set project information.  PROJECT_NAME: project file name (read-only, is_set will be ignored)  
---PROJECT_TITLE: title field from Project Settings/Notes dialog  
---PROJECT_AUTHOR: author field from Project Settings/Notes dialog  
---TRACK_GROUP_NAME:X: track group name, X should be 1..64  
---MARKER_GUID:X : get the GUID (unique ID) of the marker or region with index X, where X is the index passed to EnumProjectMarkers, not necessarily the displayed number (read-only)
---MARKER_INDEX_FROM_GUID:{GUID} : get the GUID index of the marker or region with GUID {GUID} (read-only)
---OPENCOPY_CFGIDX : integer for the configuration of format to use when creating copies/applying FX. 0=wave (auto-depth), 1=APPLYFX_FORMAT, 2=RECORD_FORMAT
---RECORD_PATH: recording directory -- may be blank or a relative path, to get the effective path see [GetProjectPathEx](#GetProjectPathEx)  
---RECORD_PATH_SECONDARY: secondary recording directory  
---RECORD_FORMAT : base64-encoded sink configuration (see project files, etc). Callers can also pass a simple 4-byte string (non-base64-encoded), e.g. "evaw" or "l3pm", to use default settings for that sink type.
---APPLYFX_FORMAT : base64-encoded sink configuration (see project files, etc). Used only if RECFMT_OPENCOPY is set to 1. Callers can also pass a simple 4-byte string (non-base64-encoded), e.g. "evaw" or "l3pm", to use default settings for that sink type.
---RENDER_FILE: render directory  
---RENDER_PATTERN: render file name (may contain wildcards)  
---RENDER_METADATA : get or set the metadata saved with the project (not metadata embedded in project media). Example, ID3 album name metadata: valuestr="ID3:TALB" to get, valuestr="ID3:TALB|my album name" to set. Call with valuestr="" and is_set=false to get a semicolon-separated list of defined project metadata identifiers.  
---RENDER_TARGETS: semicolon separated list of filenames that would be written if the project is rendered using the most recent render settings  
---RENDER_TARGETS_EX: double-NULL (\0\0) separated list of filenames that would be written if the project is rendered using the most recent render settings  
---RENDER_STATS: (read-only) semicolon separated list of statistics for the most recently rendered files. call with valuestr="XXX" to run an action (for example, "42437"=dry run render selected items) before returning statistics.  
---              returns nothing, when user aborted rendering.
---RENDER_FORMAT: base64-encoded sink configuration (see project files, etc). Callers can also pass a simple 4-byte string (non-base64-encoded), to use default settings for that sink type.  
---RENDER_FORMAT2: base64-encoded secondary sink configuration. Callers can also pass a simple 4-byte string (non-base64-encoded), e.g. "evaw" or "l3pm", to use default settings for that sink type, or "" to disable secondary render.  
---see <a href="misc_docs/RENDER_How_RenderCFG-Base64-strings_are_encoded.txt">RENDER_How_RenderCFG-Base64-strings_are_encoded.txt</a> for how the unencoded RENDER_FORMAT-string is structured.  To just use the 4-byte-string, you can use: 
---"wave" for wave, "aiff" for aiff, "caff" for caf, "iso " for audio-cd, "ddp " for ddp, "flac" for flac, "mp3l" for mp3, "oggv" for ogg, "OggS" for Opus, "FFMP" for FFMpeg-video, "FVAX" for MP4Video/Audio on Mac, "GIF " for Gif, "LCF " for LCF, "WMF" for Windows Media Foundation(mp4, m4a), "wvpk" for wavepackRENDER_METADATA: get or set the metadata saved with the project (not metadata embedded in project media). Example, ID3 album name metadata: Uses common ID3-tagcodes like TALB(album), TPE1(Artist), etc.
---To get album tag, use "ID3:TALB", to set album tag, use "ID3:TALB|my album name".  Examples in Lua:  
---getting the album name from the metadata of the current project:          retval, albumname    = reaper.GetSetProjectInfo_String(0, "RENDER_METADATA", "ID3:TALB", false)setting the album name in the metadata of the current project:        retval, albumame_new = reaper.GetSetProjectInfo_String(0, "RENDER_METADATA", "ID3:TALB|New album name", true)Supported tags-codes are: TIT2(Title), TPE1(Artist), TPE2(Albumartist), TALB(Album), TRCK(Track), TCON(Genre), TYER(Year), TDRC(Recording time: YYYY-MM-DD), TKEY(Key), TBPM(Tempo), TSRC(International Standard Recording Code), COMM(Comment), COMM_LANG(Comment language), APIC_TYPE(Image type), APIC_DESC(Image description), APIC_FILE(Image file)  APIC_TYPE can have be of the following:  0: Other  
---1: 32x32 pixel file icon (PNG only)  
---2: Other file icon  
---3: Cover (front)  
---4: Cover (back)  
---5: Leaflet page  
---6: Media  
---7: Lead artist/Lead Performer/Solo  
---8: Artist/Performer  
---9: Conductor  
---10: Band/Orchestra  
---11: Composer  
---12: Lyricist/Text writer  
---13: Recording location  
---14: During recording  
---15: During performance  
---16: Movie/video screen capture  
---17: A bright colored fish  
---18: Illustration  
---19: Band/Artist logotype  
---20: Publisher/Studiotype  
---@param project ReaProject
---@param desc string
---@param valuestrNeedBig string
---@param is_set boolean
---@return boolean retval, string valuestrNeedBig
function reaper.GetSetProjectInfo_String(project, desc, valuestrNeedBig, is_set) end

---gets or sets project notes, notesNeedBig_sz is ignored when setting
---@param proj ReaProject
---@param set boolean
---@param notes string
---@return string notes
function reaper.GetSetProjectNotes(proj, set, notes) end

---Sets or gets repeat-state of the current project.
---@param val integer
---@return integer repeat_state
function reaper.GetSetRepeat(val) end

---Sets or gets repeat-state in a specific project.
---@param proj ReaProject
---@param val integer
---@return integer repeat_state
function reaper.GetSetRepeatEx(proj, val) end

---Gets or modifies the group membership for a track. Returns group state prior to call (each bit represents one of the 32 group numbers). if setmask has bits set, those bits in setvalue will be applied to group. Group can be one of:
---VOLUME_LEAD
---VOLUME_FOLLOW
---VOLUME_VCA_LEAD
---VOLUME_VCA_FOLLOW
---PAN_LEAD
---PAN_FOLLOW
---WIDTH_LEAD
---WIDTH_FOLLOW
---MUTE_LEAD
---MUTE_FOLLOW
---SOLO_LEAD
---SOLO_FOLLOW
---RECARM_LEAD
---RECARM_FOLLOW
---POLARITY_LEAD
---POLARITY_FOLLOW
---AUTOMODE_LEAD
---AUTOMODE_FOLLOW
---VOLUME_REVERSE
---PAN_REVERSE
---WIDTH_REVERSE
---NO_LEAD_WHEN_FOLLOW
---VOLUME_VCA_FOLLOW_ISPREFXNote: REAPER v6.11 and earlier used _MASTER and _SLAVE rather than _LEAD and _FOLLOW, which is deprecated but still supported (scripts that must support v6.11 and earlier can use the deprecated strings).
---@param tr MediaTrack
---@param groupname string
---@param setmask integer
---@param setvalue integer
---@return integer group_membership
function reaper.GetSetTrackGroupMembership(tr, groupname, setmask, setvalue) end

---deprecated -- see SetTrackStateChunk, GetTrackStateChunk
---@param track MediaTrack
---@param str string
---@return boolean retval, string str
function reaper.GetSetTrackState(track, str) end

---deprecated -- see SetTrackStateChunk, GetTrackStateChunk
---@param track MediaTrack
---@param str string
---@param isundo boolean
---@return boolean retval, string str
function reaper.GetSetTrackState2(track, str, isundo) end

---@param src PCM_source
---@return ReaProject sub_proj
function reaper.GetSubProjectFromSource(src) end

---get a take from an item by take count (zero-based)
---@param item MediaItem
---@param takeidx integer
---@return MediaItem_Take take
function reaper.GetTake(item, takeidx) end

---@param take MediaItem_Take
---@param envidx integer
---@return TrackEnvelope env
function reaper.GetTakeEnvelope(take, envidx) end

---@param take MediaItem_Take
---@param envname string
---@return TrackEnvelope env
function reaper.GetTakeEnvelopeByName(take, envname) end

---Get information about a take marker. Returns the position in media item source time, or -1 if the take marker does not exist.
---@param take MediaItem_Take
---@param idx integer
---@return number position, string name, integer|nil color
function reaper.GetTakeMarker(take, idx) end

---Retruns the filename of the mediafile in a take. returns NULL if the take is not valid
---@param take MediaItem_Take
---@return takename 
function reaper.GetTakeName(take) end

---Returns number of stretch markers in take
---@param take MediaItem_Take
---@return integer count_stretch_marker
function reaper.GetTakeNumStretchMarkers(take) end

---Gets information on a stretch marker, idx is 0..n. 
---Returns -1 if stretch marker not valid. posOut will be set to position in item
---srcposOutOptional will be set to source media position. Returns index. if input index is -1, the following  marker is found using position (or source position if position is -1). 
---If position/source position are used to find marker position, their values are not updated.
---@param take MediaItem_Take
---@param idx integer
---@return integer retval, number pos, number|nil srcpos
function reaper.GetTakeStretchMarker(take, idx) end

---See SetTakeStretchMarkerSlope
---@param take MediaItem_Take
---@param idx integer
---@return number take_marker_slope
function reaper.GetTakeStretchMarkerSlope(take, idx) end

---Get information about a specific FX parameter knob (see CountTCPFXParms).
---@param project ReaProject
---@param track MediaTrack
---@param index integer
---@return boolean retval, integer fxindex, integer parmidx
function reaper.GetTCPFXParm(project, track, index) end

---finds the playrate and target length to insert this item stretched to a round power-of-2 number of bars, between 1/8 and 256
---@param source PCM_source
---@param srcscale number
---@param position number
---@param mult number
---@return boolean retval, number rate, number targetlen
function reaper.GetTempoMatchPlayRate(source, srcscale, position, mult) end

---Get information about a tempo/time signature marker. 
---@param proj ReaProject
---@param ptidx integer
---@return boolean retval, number timepos, integer measurepos, number beatpos, number bpm, integer timesig_num, integer timesig_denom, boolean lineartempo
function reaper.GetTempoTimeSigMarker(proj, ptidx) end

---Returns the theme color specified, or -1 on failure. If the low bit of flags is set, the color as originally specified by the theme (before any transformations) is returned, otherwise the current (possibly transformed and modified) color is returned. See SetThemeColor for a list of valid ini_key.
---@param ini_key string
---@param flags integer
---@return integer retval
function reaper.GetThemeColor(ini_key, flags) end

---Hit tests a point in screen coordinates. Updates infoOut with information such as "arrange", "fx_chain", "fx_0" (first FX in chain, floating) or Walter-elements. 
---When hovering above a track, info is "arrange", while over envelopes, it is "envelope x" where x is the number of the active(!) envelope.
---If a track panel is hit, string will begin with "tcp" or "mcp" or "tcp.mute" etc (future versions may append additional information). May return NULL with valid info string to indicate non-track thing.
---@param screen_x integer
---@param screen_y integer
---@return MediaTrack|nil tr, string info
function reaper.GetThingFromPoint(screen_x, screen_y) end

---Return toggle-state of an action. See GetToggleCommandStateEx.
---See NamedCommandLookup() for the correct command_id.
---@param command_id integer
---@return integer retval
function reaper.GetToggleCommandState(command_id) end

---Return toggle-state of an action.For the main action context, the MIDI editor, or the media explorer, returns the toggle state of the action. For the MIDI editor, the action state for the most recently focused window will be returned.
---See NamedCommandLookup() for the correct command_id.
---@param section_id integer
---@param command_id integer
---@return integer retval
function reaper.GetToggleCommandStateEx(section_id, command_id) end

---gets a tooltip window,in case you want to ask it for font information. Can return NULL.
---@return HWND hwnd
function reaper.GetTooltipWindow() end

---get a track from a project by track count (zero-based) (proj=0 for active project)
---@param proj ReaProject
---@param trackidx integer
---@return MediaTrack tr
function reaper.GetTrack(proj, trackidx) end

---return the track mode, regardless of global override
---@param tr MediaTrack
---@return integer automation_mode
function reaper.GetTrackAutomationMode(tr) end

---Returns the track custom color as OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). Black is returned as 0x01000000, no color setting is returned as 0.
---@param track MediaTrack
---@return integer color
function reaper.GetTrackColor(track) end

---Get the depth of a track within a folder structure
---@param track MediaTrack
---@return integer tr_depth
function reaper.GetTrackDepth(track) end

---Gets an envelope of a track.Note: to create an FX-envelope, use GetFXEnvelope with parameter create=true
---@param track MediaTrack
---@param envidx integer
---@return TrackEnvelope env
function reaper.GetTrackEnvelope(track, envidx) end

---Gets a built-in track envelope by configuration chunk name, e.g. "<VOLENV" or GUID string, like "{B577250D-146F-B544-9B34-F24FBE488F1F}".Note: to create an FX-envelope, use GetFXEnvelope with parameter create=true
---@param tr MediaTrack
---@param cfgchunkname_or_guid string
---@return TrackEnvelope env
function reaper.GetTrackEnvelopeByChunkName(tr, cfgchunkname_or_guid) end

---Gets a TrackEnvelope by its name.Note: to create an FX-envelope, use GetFXEnvelope with parameter create=true
---@param track MediaTrack
---@param envname string
---@return TrackEnvelope 
function reaper.GetTrackEnvelopeByName(track, envname) end

---Returns the track from the screen coordinates specified. If the screen coordinates refer to a window associated to the track (such as FX), the track will be returned. infoOutOptional will be set to 1 if it is likely an envelope, 2 if it is likely a track FX.Note: You can not get the track at screen-coordinates, where it is hidden by other windows.See GetThingFromPoint
---@param screen_x integer
---@param screen_y integer
---@return MediaTrack retval, integer|nil info
function reaper.GetTrackFromPoint(screen_x, screen_y) end

---Get the guid of a MediaTrack
---@param tr MediaTrack
---@return string GUID
function reaper.GetTrackGUID(tr) end

---@param tr MediaTrack
---@param itemidx integer
---@return MediaItem item
function reaper.GetTrackMediaItem(tr, itemidx) end

---Get all MIDI lyrics on the track. Lyrics will be returned as one string with tabs between each word. flag&1: double tabs at the end of each measure and triple tabs when skipping measures, 
---flag&2: each lyric is preceded by its beat position in the project example with flag=2: "1.1.2\tLyric for measure 1 beat 2\t2.1.1\tLyric for measure 2 beat 1 ").See SetTrackMIDILyrics
---@param track MediaTrack
---@param flag integer
---@return boolean retval, string buf
function reaper.GetTrackMIDILyrics(track, flag) end

---see GetTrackMIDINoteNameEx
---@param track integer
---@param pitch integer
---@param chan integer
---@return string notename
function reaper.GetTrackMIDINoteName(track, pitch, chan) end

---Get note/CC name. pitch 128 for CC0 name, 129 for CC1 name, etc. See SetTrackMIDINoteNameEx
---@param proj ReaProject
---@param track MediaTrack
---@param pitch integer
---@param chan integer
---@return string midi_notename
function reaper.GetTrackMIDINoteNameEx(proj, track, pitch, chan) end

---@param proj ReaProject
---@param track MediaTrack
---@return integer note_lo_retval, integer note_hi
function reaper.GetTrackMIDINoteRange(proj, track) end

---Returns "MASTER" for master track, "Track N" if track has no name.
---@param track MediaTrack
---@return boolean retval, string buf
function reaper.GetTrackName(track) end

---Get the number of MediaItems of a MediaTrack
---@param tr MediaTrack
---@return integer num_media_items
function reaper.GetTrackNumMediaItems(tr) end

---returns number of sends/receives/hardware outputsFor ReaRoute-users: the outputs are hardware outputs, but with 512 added to the destination channel index (512 is the first rearoute channel, 513 the second, etc).
---@param tr MediaTrack
---@param category integer
---@return integer count_sends
function reaper.GetTrackNumSends(tr, category) end

---Gets the name of a track, that MediaTrack is receiving.If the track has no name, the name will be something like "Track 2".See GetTrackSendName.
---@param track MediaTrack
---@param recv_index integer
---@return boolean retval, string receive_trackname
function reaper.GetTrackReceiveName(track, recv_index) end

---Returns the mute-state of a track, that MediaTrack is receiving.See GetTrackSendUIMute.
---@param track MediaTrack
---@param recv_index integer
---@return boolean retval, boolean mute
function reaper.GetTrackReceiveUIMute(track, recv_index) end

---Returns the pan and volume-values of a track that MediaTrack is receiving.Note: convert the volumevalue to dB using in Lua: dB_volume = math.log(volume)*8.68588963806See GetTrackSendUIVolPan
---@param track MediaTrack
---@param recv_index integer
---@return boolean retval, number volume, number pan
function reaper.GetTrackReceiveUIVolPan(track, recv_index) end

---Get send/receive/hardware output numerical-value attributes.
---category is <0 for receives, 0=sends, >0 for hardware outputs
---parameter names:  B_MUTE : bool *
---  B_PHASE : bool * : true to flip phase
---  B_MONO : bool *
---  D_VOL : double * : 1.0 = +0dB etc
---  D_PAN : double * : -1..+1
---  D_PANLAW : double * : 1.0=+0.0db, 0.5=-6dB, -1.0 = projdef etc
---  I_SENDMODE : int * : 0=post-fader, 1=pre-fx, 2=post-fx (deprecated), 3=post-fx
---  I_AUTOMODE : int * : automation mode (-1=use track automode, 0=trim/off, 1=read, 2=touch, 3=write, 4=latch)
---  I_SRCCHAN : int * : -1 for no audio send. Low 10 bits specify channel offset, and higher bits specify channel count. (srcchan>>10) == 0 for stereo, 1 for mono, 2 for 4 channel, 3 for 6 channel, etc.
---  I_DSTCHAN : int * : low 10 bits are destination index, &1024 set to mix to mono.
---  I_MIDIFLAGS : int * : low 5 bits=source channel 0=all, 1-16, next 5 bits=dest channel, 0=orig, 1-16=chanP_DESTTRACK : read only, returns MediaTrack *, destination track, only applies for sends/recvs
---  P_DESTTRACK : MediaTrack * : destination track, only applies for sends/recvs (read-only)
---  P_SRCTRACK : MediaTrack * : source track, only applies for sends/recvs (read-only)
---  P_ENV:&envchunkname : TrackEnvelope * : call with :&VOLENV, :&PANENV, etc appended (read-only)For ReaRoute-users: the outputs are hardware outputs, but with 512 added to the destination channel index (512 is the first rearoute channel, 513 the second, etc).Note: convert the D_VOL-volume to dB using in Lua: dB_volume = math.log(volume)*8.68588963806
---@param tr MediaTrack
---@param category integer
---@param sendidx integer
---@param parmname string
---@return number value
function reaper.GetTrackSendInfo_Value(tr, category, sendidx, parmname) end

---gets the name of a track, that MediaTrack is sending to
---send_idx>=0 for hw outputs, >=nb_of_hw_outputs for sends. If the send-track has no name, send_name can be something like "Track 2"See GetTrackReceiveName
---@param track MediaTrack
---@param send_index integer
---@return boolean retval, string send_name
function reaper.GetTrackSendName(track, send_index) end

---send_idx>=0 for hw outputs, >=nb_of_hw_outputs for sends. See GetTrackReceiveUIMute.
---@param track MediaTrack
---@param send_index integer
---@return boolean retval, boolean mute
function reaper.GetTrackSendUIMute(track, send_index) end

---send_idx>=0 for hw outputs, >=nb_of_hw_outputs for sends. See GetTrackReceiveUIVolPanNote: convert the volumevalue to dB using in Lua: dB_volume = math.log(volume)*8.68588963806
---@param track MediaTrack
---@param send_index integer
---@return boolean retval, number volume, number pan
function reaper.GetTrackSendUIVolPan(track, send_index) end

---Gets track state, returns track name.
---flags will be set to:
---&1=folder
---&2=selected
---&4=has fx enabled
---&8=muted
---&16=soloed
---&32=SIP'd (with &16)
---&64=rec armed
---&128=rec monitoring on
---&256=rec monitoring auto
---&512=hide from TCP
---&1024=hide from MCP
---@param track MediaTrack
---@return string retval, integer flags
function reaper.GetTrackState(track) end

---Gets the RPPXML state of a track, returns true if successful. Undo flag is a performance/caching hint.
---@param track MediaTrack
---@param str string
---@param isundo boolean
---@return boolean retval, string str
function reaper.GetTrackStateChunk(track, str, isundo) end

---@param track MediaTrack
---@return boolean retval, boolean mute
function reaper.GetTrackUIMute(track) end

---@param track MediaTrack
---@return boolean retval, number pan1, number pan2, integer panmode
function reaper.GetTrackUIPan(track) end

---@param track MediaTrack
---@return boolean retval, number volume, number pan
function reaper.GetTrackUIVolPan(track) end

---retrieves the last timestamps of audio xrun (yellow-flash, if available), media xrun (red-flash), and the current time stamp (all milliseconds)
---@return integer audio_xrun, integer media_xrun, integer curtime
function reaper.GetUnderrunTime() end

---Opens a filerequester, where a user can select a file.
---The requester only returns the file, but doesn't open or write to it. That said, this function can be used for both use-cases, BUT: keep in mind, that it shows an "open"-button, even if you want to use it in code for saving a file. You also can't use it for "create new file"-usecases, as you can't choose nonexisting files.
---@param filenameNeed4096 string
---@param title string
---@param defext string
---@return boolean retval, string filenameNeed4096
function reaper.GetUserFileNameForRead(filenameNeed4096, title, defext) end

---Opens a window with input-fields to get values from the user.
---If a caption begins with *, for example "*password", the edit field will not display the input text.
---Maximum fields is 16. Values are returned as a comma/custom separator-separated string. 
---Returns false if the user canceled the dialog. You can supply special extra information via additional caption fields: extrawidth=XXX to increase text field width, separator=X to use a different separator for returned fields(separator=\n is recommended).Example:<pre><code>
---    retval, retvals_csv = reaper.GetUserInputs("Title", 2, "Hello,World, separator=\n", "defaultvalue1\ndefaultvalue2")
---</code></pre>will return the values input by the user, separated by a newline.\n is recommended, as this allows the user entering everything, a one-lined-inputbox can handle.Important: the separator-field in the captions has no effect on how captions in parameter captions_csv are separated from each other. They still need to be separated by commas!Note: the parameter retvals_csv follows undisclosed csv rules. This is important when you want to set the default-captions for multiple input-field.
---For instance every entry for each input-field: - must contain an even number of quotes/single quotes
---- every ( or must be closed by with )otherwise the separator will be ignored and the default-retvals will show in the wrong fields.Example:
---<pre><code>
---a retval_csv of I'm enlightened,I am too
---</code></pre>
---with one singlequote in it (the one in I'm) will NOT be shown in two fields<pre><code>
---I'm enlightened
---I am too
---</code></pre>but rather in one field as <pre><code>
---I'm enlightened,I am too
---</code></pre>These can't be escaped due Reaper's API-limitation. Keep this in mind!Another note when only having one entry:
---You may run into the situation of wanting to have a caption, that has a , in it.
---This could be interpreted as separator, so an caption entry like:
---"this, is, my, entry"
---will be shown like
---"this"To avoid this, use separator=\b in the caption_csv, so
---"this, is, my, entry, separator=\b"
---will be shown as
---"this, is, my, entry".
---
---@param title string
---@param num_inputs integer
---@param captions_csv string
---@param retvals_csv string
---@return boolean retval, string retvals_csv
function reaper.GetUserInputs(title, num_inputs, captions_csv, retvals_csv) end

---Go to marker. 
---Move Editcursor to a given marker. When playing, the playcursor moves to the marker as well.For Regions, use GoToRegion.
---@param proj ReaProject
---@param marker_index integer
---@param use_timeline_order boolean
function reaper.GoToMarker(proj, marker_index, use_timeline_order) end

---Go to beginning of a region.
---Seek to region after current region finishes playing (smooth seek). 
---@param proj ReaProject
---@param region_index integer
---@param use_timeline_order boolean
function reaper.GoToRegion(proj, region_index, use_timeline_order) end

---Runs the system color chooser dialog. Returns 0 if the user cancels the dialog.
---@param hwnd HWND
---@return integer retval, integer color
function reaper.GR_SelectColor(hwnd) end

---this is just like win32 GetSysColor() but can have overrides.
---@param t integer
---@return integer color
function reaper.GSC_mainwnd(t) end

---dest should be at least 64 chars long to be safe
---@param gGUID string
---@param destNeed64 string
---@return string destNeed64
function reaper.guidToString(gGUID, destNeed64) end

---Returns true if there exists an extended state value for a specific section and key.
---@param section string
---@param key string
---@return boolean retval
function reaper.HasExtState(section, key) end

---returns name of track plugin that is supplying MIDI programs,or NULL if there is none
---@param track integer
---@return string plugin_name
function reaper.HasTrackMIDIPrograms(track) end

---returns name of track plugin that is supplying MIDI programs,or NULL if there is none
---@param proj ReaProject
---@param track MediaTrack
---@return string plugin_name
function reaper.HasTrackMIDIProgramsEx(proj, track) end

---Displays an information in the help and information-display, underneath the TCP(might be missing, in certain themes).
---@param helpstring string
---@param is_temporary_help boolean
function reaper.Help_Set(helpstring, is_temporary_help) end

---@param in_ string
---@param out string
---@return string out
function reaper.image_resolve_fn(in_, out) end

---Insert a new automation item. pool_id < 0 collects existing envelope points into the automation item
---if pool_id is >= 0 the automation item will be a new instance of that pool (which will be created as an empty instance if it does not exist). Returns the index of the item, suitable for passing to other automation item API functions. See GetSetAutomationItemInfo.
---@param env TrackEnvelope
---@param pool_id integer
---@param position number
---@param length number
---@return integer retval
function reaper.InsertAutomationItem(env, pool_id, position, length) end

---Insert an envelope point. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done. See InsertEnvelopePointEx.
---@param envelope TrackEnvelope
---@param time number
---@param value number
---@param shape integer
---@param tension number
---@param selected boolean
---@param noSort? boolean
---@return boolean retval
function reaper.InsertEnvelopePoint(envelope, time, value, shape, tension, selected, noSort) end

---Insert an envelope point. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done.
---autoitem_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
---For automation items, pass autoitem_idx|0x10000000 to base ptidx on the number of points in one full loop iteration,
---even if the automation item is trimmed so that not all points are visible.
---Otherwise, ptidx will be based on the number of visible points in the automation item, including all loop iterations.See CountEnvelopePointsEx, GetEnvelopePointEx, SetEnvelopePointEx, DeleteEnvelopePointEx.
---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@param time number
---@param value number
---@param shape integer
---@param tension number
---@param selected boolean
---@param noSort? boolean
---@return boolean retval
function reaper.InsertEnvelopePointEx(envelope, autoitem_idx, time, value, shape, tension, selected, noSort) end

---mode: 
---0=add to current track, 
---1=add new track, 
---3=add to selected items as takes, 
---&4=stretch/loop to fit time sel, 
---&8=try to match tempo 1x, 
---&16=try to match tempo 0.5x, 
---&32=try to match tempo 2x, 
---&64=don't preserve pitch when matching tempo, 
---&128=no loop/section if startpct/endpct set, 
---&256=force loop regardless of global preference for looping imported items, 
---&512=use high word as absolute track index if mode&3==0 or mode&2048, 
---&1024=insert into reasamplomatic on a new track (add 1 to insert on last selected track), 
---&2048=insert into open reasamplomatic instance (add 512 to use high word as absolute track index), 
---&4096=move to source preferred position (BWF start offset), 
---&8192=reverseExample:
---To insert an item at a specific trackindex, use:
---<pre><code>
---    TrackIndex=3              -- set this to the track you want
---    TrackIndex=TrackIndex<<16 -- move the index to high-word-destination for further use
---    reaper.InsertMedia("C:\\test3.mp3", 0+512+TrackIndex) -- insert at track; it is important to add 512 in this to mode!
---</code></pre>
---@param file string
---@param mode integer
---@return integer retval
function reaper.InsertMedia(file, mode) end

---see InsertMedia for more details
---@param file string
---@param mode integer
---@param startpct number
---@param endpct number
---@param pitchshift number
---@return integer retval
function reaper.InsertMediaSection(file, mode, startpct, endpct, pitchshift) end

---inserts a track at idx,of course this will be clamped to 0..GetNumTracks().
---@param idx integer
---@param wantDefaults boolean
function reaper.InsertTrackAtIndex(idx, wantDefaults) end

---Tests a file extension (i.e. "wav" or "mid") to see if it's a media extension.
---If wantOthers is set, then "RPP", "TXT" and other project-type formats will also pass.
---@param ext string
---@param wantOthers boolean
---@return boolean is_mediaextension
function reaper.IsMediaExtension(ext, wantOthers) end

---Get, if a MediaItem is selected or not.
---@param item MediaItem
---@return boolean item_selected
function reaper.IsMediaItemSelected(item) end

---Is the project dirty (needing save)? Always returns 0 if 'undo/prompt to save' is disabled in preferences.A project becomes dirty, as soon as it was changed since creation/last saving.
---@param proj ReaProject
---@return integer project_dirty
function reaper.IsProjectDirty(proj) end

---Get, if a MediaTrack is selected or not.
---@param track MediaTrack
---@return boolean track_selected
function reaper.IsTrackSelected(track) end

---Gets visibility-state of a MediaTrack.
---@param track MediaTrack
---@param mixer boolean
---@return boolean track_visible
function reaper.IsTrackVisible(track, mixer) end

---creates a joystick device
---@param guidGUID string
---@return joystick_device joystick
function reaper.joystick_create(guidGUID) end

---destroys a joystick device
---@param device joystick_device
function reaper.joystick_destroy(device) end

---enumerates installed devices, returns GUID as a string
---@param index integer
---@return string retval, string|nil namestr
function reaper.joystick_enum(index) end

---returns axis value (-1..1)
---@param dev joystick_device
---@param axis integer
---@return number joystick_axis_value
function reaper.joystick_getaxis(dev, axis) end

---returns button pressed mask, 1=first button, 2=second...
---@param dev joystick_device
---@return integer joystick_button_mask
function reaper.joystick_getbuttonmask(dev) end

---returns button count
---@param dev joystick_device
---@return integer retval, integer|nil axes, integer|nil povs
function reaper.joystick_getinfo(dev) end

---returns POV value (usually 0..655.35, or 655.35 on error)
---@param dev joystick_device
---@param pov integer
---@return number joystick_pov
function reaper.joystick_getpov(dev, pov) end

---Updates joystick state from hardware, returns true if successful (joystick_get* will not be valid until joystick_update() is called successfully)
---@param dev joystick_device
---@return boolean joystick_state
function reaper.joystick_update(dev) end

---Returns the description of an action.
---@param section KbdSectionInfo
---@param idx integer
---@return integer retval, string name
function reaper.kbd_enumerateActions(section, idx) end

---Returns false if the line is entirely offscreen.
---@param pX1 integer
---@param pY1 integer
---@param pX2 integer
---@param pY2 integer
---@param xLo integer
---@param yLo integer
---@param xHi integer
---@param yHi integer
---@return boolean retval, integer pX1, integer pY1, integer pX2, integer pY2
function reaper.LICE_ClipLine(pX1, pY1, pX2, pY2, xLo, yLo, xHi, yHi) end

---Returns a localized version of src_string, in section section. flags can have 1 set to only localize if sprintf-style formatting matches the original.
---@param src_string string
---@param section string
---@param flags integer
---@return string retval
function reaper.LocalizeString(src_string, section, flags) end

---Move the loop selection left or right in steps according to snap-settings(when snap is enabled).
---@param project ReaProject
---@param direction integer
---@return boolean snap_state
function reaper.Loop_OnArrow(project, direction) end

---Performs an action belonging to the main action section. 
---To perform non-native actions (ReaScripts, custom or extension plugins' actions) safely, see NamedCommandLookup().
---See Main_OnCommandEx.
---@param command integer
---@param flag integer
function reaper.Main_OnCommand(command, flag) end

---Performs an action belonging to the main action section. To perform non-native actions (ReaScripts, custom or extension plugins' actions) safely, see NamedCommandLookup().
---@param command integer
---@param flag integer
---@param proj ReaProject
function reaper.Main_OnCommandEx(command, flag, proj) end

---opens a project. will prompt the user to save unless name is prefixed with 'noprompt:'. 
---    example: "noprompt:projectfile.rpp"If name is prefixed with 'template:', project file will be loaded as a template.
---    example: "template:projectfile.rpp"You can combine both: "template:noprompt:projectfile.rpp"If passed a .RTrackTemplate file, adds the template to the existing project.
---@param name string
function reaper.Main_openProject(name) end

---Save the project.
---Optional with a save-dialog.
---@param proj ReaProject
---@param forceSaveAs boolean
function reaper.Main_SaveProject(proj, forceSaveAs) end

---Save the project and allows passing a filename.If project can not be saved, it will show an errordialog to the user.If the projectfilename already exists, it might create an alternative project-file with the extension rpp-TEMP.Will obey backup-file-settings, so a file using the extension rpp-bak might be created.
---@param proj ReaProject
---@param filename string
---@param options integer
function reaper.Main_SaveProjectEx(proj, filename, options) end

---@param ignoremask integer
function reaper.Main_UpdateLoopInfo(ignoremask) end

---Marks project as dirty (needing save) if 'undo/prompt to save' is enabled in preferences.
---@param proj ReaProject
function reaper.MarkProjectDirty(proj) end

---If track is supplied, item is ignored
---@param track MediaTrack
---@param item MediaItem
function reaper.MarkTrackItemsDirty(track, item) end

---Get the playrate of the project.
---@param project ReaProject
---@return number mas_playrate
function reaper.Master_GetPlayRate(project) end

---@param time_s number
---@param proj ReaProject
---@return number mas_playrate_time
function reaper.Master_GetPlayRateAtTime(time_s, proj) end

---@return number mas_tempo
function reaper.Master_GetTempo() end

---Convert play rate to/from a value between 0 and 1, representing the position on the project playrate slider.
---@param playrate number
---@param isnormalized boolean
---@return number mas_norm_playrate
function reaper.Master_NormalizePlayRate(playrate, isnormalized) end

---Convert the tempo to/from a value between 0 and 1, representing bpm in the range of 40-296 bpm.
---@param bpm number
---@param isnormalized boolean
---@return number mas_norm_tempo
function reaper.Master_NormalizeTempo(bpm, isnormalized) end

---Shows Messagebox with user-clickable buttons.
---@param msg string
---@param title string
---@param type integer
---@return integer retval
function reaper.MB(msg, title, type) end

---Returns 1 if the track holds the item, 2 if the track is a folder containing the track that holds the item, etc.
---@param item MediaItem
---@param track MediaTrack
---@return integer retval
function reaper.MediaItemDescendsFromTrack(item, track) end

---Count the number of notes, CC events, and text/sysex events in a given MIDI item.
---@param take MediaItem_Take
---@return integer retval, number notecnt, number ccevtcnt, number textsyxevtcnt
function reaper.MIDI_CountEvts(take) end

---Delete a MIDI CC event.
---@param take MediaItem_Take
---@param ccidx integer
---@return boolean retval
function reaper.MIDI_DeleteCC(take, ccidx) end

---Delete a MIDI event.
---@param take MediaItem_Take
---@param evtidx integer
---@return boolean retval
function reaper.MIDI_DeleteEvt(take, evtidx) end

---Delete a MIDI note.
---@param take MediaItem_Take
---@param noteidx integer
---@return boolean retval
function reaper.MIDI_DeleteNote(take, noteidx) end

---Delete a MIDI text or sysex event.
---@param take MediaItem_Take
---@param textsyxevtidx integer
---@return boolean retval
function reaper.MIDI_DeleteTextSysexEvt(take, textsyxevtidx) end

---Disable sorting for all MIDI insert, delete, get and set functions, until MIDI_Sort is called.
---@param take MediaItem_Take
function reaper.MIDI_DisableSort(take) end

---Returns the index of the next selected MIDI CC event after ccidx (-1 if there are no more selected events).
---@param take MediaItem_Take
---@param ccidx integer
---@return integer sel_midicc_index
function reaper.MIDI_EnumSelCC(take, ccidx) end

---Returns the index of the next selected MIDI event after evtidx (-1 if there are no more selected events).
---@param take MediaItem_Take
---@param evtidx integer
---@return integer sel_midi_evt_index
function reaper.MIDI_EnumSelEvts(take, evtidx) end

---Returns the index of the next selected MIDI note after noteidx (-1 if there are no more selected events).
---@param take MediaItem_Take
---@param noteidx integer
---@return integer sel_midi_note_index
function reaper.MIDI_EnumSelNotes(take, noteidx) end

---Returns the index of the next selected MIDI text/sysex event after textsyxidx (-1 if there are no more selected events).
---@param take MediaItem_Take
---@param textsyxidx integer
---@return integer sel_midi_sysex_index
function reaper.MIDI_EnumSelTextSysexEvts(take, textsyxidx) end

---Get all MIDI data. MIDI buffer is returned as a list of { int offset, char flag, int msglen, unsigned char msg[] }.   offset: MIDI ticks from previous event
---   flag: &1=selected &2=muted
---   flag high 4 bits for CC shape: &16=linear, &32=slow start/end, &16|32=fast start, &64=fast end, &64|16=bezier
---   msg: the MIDI message.A meta-event of type 0xF followed by 'CCBZ ' and 5 more bytes represents bezier curve data for the previous MIDI event: 1 byte for the bezier type (usually 0) and 4 bytes for the bezier tension as a float.
---For tick intervals longer than a 32 bit word can represent, zero-length meta events may be placed between valid events.See MIDI_SetAllEvts.
---@param take MediaItem_Take
---@return boolean retval, string buf
function reaper.MIDI_GetAllEvts(take) end

---Get MIDI CC event properties.
---@param take MediaItem_Take
---@param ccidx integer
---@return boolean retval, boolean selected, boolean muted, number ppqpos, integer chanmsg, integer|nil chan, integer msg2, integer msg3
function reaper.MIDI_GetCC(take, ccidx) end

---Get CC shape and bezier tension. See MIDI_GetCC, MIDI_SetCCShape
---@param take MediaItem_Take
---@param ccidx integer
---@return boolean retval, integer shape, number beztension
function reaper.MIDI_GetCCShape(take, ccidx) end

---Get MIDI event properties of a take.
---@param take MediaItem_Take
---@param evtidx integer
---@return boolean retval, boolean selected, boolean muted, number ppqpos, string msg
function reaper.MIDI_GetEvt(take, evtidx) end

---Returns the most recent MIDI editor grid size for this MIDI take, in QN. Swing is between 0 and 1. Note length is 0 if it follows the grid size.
---@param take MediaItem_Take
---@return number retval, number|nil swing, number|nil noteLen
function reaper.MIDI_GetGrid(take) end

---Get a string that only changes when the MIDI data changes. If notesonly==true, then the string changes only when the MIDI notes change. 
---@param take MediaItem_Take
---@param notesonly boolean
---@return boolean retval, string hash
function reaper.MIDI_GetHash(take, notesonly) end

---Get MIDI note properties.
---@param take MediaItem_Take
---@param noteidx integer
---@return boolean retval, boolean selected, boolean muted, number startppqpos, number endppqpos, integer chan, integer pitch, integer vel
function reaper.MIDI_GetNote(take, noteidx) end

---Returns the MIDI tick (ppq) position corresponding to the end of the measure.
---@param take MediaItem_Take
---@param ppqpos number
---@return number endposition
function reaper.MIDI_GetPPQPos_EndOfMeasure(take, ppqpos) end

---Returns the MIDI tick (ppq) position corresponding to the start of the measure.
---@param take MediaItem_Take
---@param ppqpos number
---@return number startposition
function reaper.MIDI_GetPPQPos_StartOfMeasure(take, ppqpos) end

---Returns the MIDI tick (ppq) position corresponding to a specific project time in quarter notes.
---@param take MediaItem_Take
---@param projqn number
---@return number ppq_position
function reaper.MIDI_GetPPQPosFromProjQN(take, projqn) end

---Returns the MIDI tick (ppq) position corresponding to a specific project time in seconds.
---@param take MediaItem_Take
---@param projtime number
---@return number ppq_position
function reaper.MIDI_GetPPQPosFromProjTime(take, projtime) end

---Returns the project time in quarter notes corresponding to a specific MIDI tick (ppq) position.
---@param take MediaItem_Take
---@param ppqpos number
---@return number qn_project_time
function reaper.MIDI_GetProjQNFromPPQPos(take, ppqpos) end

---Returns the project time in seconds corresponding to a specific MIDI tick (ppq) position.
---@param take MediaItem_Take
---@param ppqpos number
---@return number seconds_project_time
function reaper.MIDI_GetProjTimeFromPPQPos(take, ppqpos) end

---Gets a recent MIDI input event from the global history. parameters:
---idx=0 for the most recent event, which also latches to the latest MIDI event state (to get a more recent list, calling with idx=0 is necessary). 
---idx=1 next most recent event, returns a non-zero sequence number for the event, or zero if no more events. retvals:
---tsOut/ts will be set to the timestamp in samples relative to the current position (0 is current, -48000 is one second ago, etc). devIdxOut/devIdx will have the low 16 bits set to the input device index, and 0x10000 will be set if device was enabled only for control. projPosOut/projPos will be set to project position in seconds if project was playing back at time of event, otherwise -1. Large SysEx events will not be included in this event list.
---@param idx integer
---@return integer retval, string buf, integer ts, integer devIdx, number projPos, integer projLoopCnt
function reaper.MIDI_GetRecentInputEvent(idx) end

---Get the active scale in the media source, if any. root 0=C, 1=C#, etc. scale &0x1=root, &0x2=minor 2nd, &0x4=major 2nd, &0x8=minor 3rd, &0xF=fourth, etc.
---@param take MediaItem_Take
---@return boolean retval, number root, number scale, string name
function reaper.MIDI_GetScale(take) end

---Get MIDI meta-event properties. Allowable types are -1:sysex (msg should not include bounding F0..F7), 1-14:MIDI text event types, 15=REAPER notation event. For all other meta-messages, type is returned as -2 and msg returned as all zeroes. See MIDI_GetEvt.
---@param take MediaItem_Take
---@param textsyxevtidx integer
---@param selected? boolean
---@param muted? boolean
---@param ppqpos? number
---@param type? integer
---@param msg? string
---@return boolean retval, boolean|nil selected, boolean|nil muted, number|nil ppqpos, integer|nil type, string|nil msg
function reaper.MIDI_GetTextSysexEvt(take, textsyxevtidx, selected, muted, ppqpos, type, msg) end

---Get a string that only changes when the MIDI data changes. If notesonly==true, then the string changes only when the MIDI notes change. See MIDI_GetHash
---@param track MediaTrack
---@param notesonly boolean
---@return boolean retval, string hash
function reaper.MIDI_GetTrackHash(track, notesonly) end

---Insert a new MIDI CC event.
---@param take MediaItem_Take
---@param selected boolean
---@param muted boolean
---@param ppqpos number
---@param chanmsg integer
---@param chan integer
---@param msg2 integer
---@param msg3 integer
---@return boolean retval
function reaper.MIDI_InsertCC(take, selected, muted, ppqpos, chanmsg, chan, msg2, msg3) end

---Opens MIDI devices as configured in preferences. force_reinit_input and force_reinit_output force a particular device index to close/re-open (pass -1 to not force any devices to reopen).
---@param force_reinit_input integer
---@param force_reinit_output integer
function reaper.midi_init(force_reinit_input, force_reinit_output) end

---Insert a new MIDI event.
---@param take MediaItem_Take
---@param selected boolean
---@param muted boolean
---@param ppqpos number
---@param bytestr string
---@return boolean retval
function reaper.MIDI_InsertEvt(take, selected, muted, ppqpos, bytestr) end

---Insert a new MIDI note. Set noSort if inserting multiple events, then call MIDI_Sort when done.
---@param take MediaItem_Take
---@param selected boolean
---@param muted boolean
---@param startppqpos number
---@param endppqpos number
---@param chan integer
---@param pitch integer
---@param vel integer
---@param noSort? boolean
---@return boolean retval
function reaper.MIDI_InsertNote(take, selected, muted, startppqpos, endppqpos, chan, pitch, vel, noSort) end

---Insert a new MIDI text or sysex event. Allowable types are -1:sysex (msg should not include bounding F0..F7), 1-14:MIDI text event types, 15=REAPER notation event.
---@param take MediaItem_Take
---@param selected boolean
---@param muted boolean
---@param ppqpos number
---@param type integer
---@param bytestr string
---@return boolean retval
function reaper.MIDI_InsertTextSysexEvt(take, selected, muted, ppqpos, type, bytestr) end

---Reset (close and re-open) all MIDI devices
function reaper.midi_reinit() end

---Select or deselect all MIDI content.
---@param take MediaItem_Take
---@param select boolean
function reaper.MIDI_SelectAll(take, select) end

---Set all MIDI data. MIDI buffer is passed in as a list of { int offset, char flag, int msglen, unsigned char msg[] }.   offset: MIDI ticks from previous event
---   flag: &1=selected &2=muted
---   flag high 4 bits for CC shape: &16=linear, &32=slow start/end, &16|32=fast start, &64=fast end, &64|16=bezier
---   msg: the MIDI message.A meta-event of type 0xF followed by 'CCBZ ' and 5 more bytes represents bezier curve data for the previous MIDI event: 1 byte for the bezier type (usually 0) and 4 bytes for the bezier tension as a float.
---For tick intervals longer than a 32 bit word can represent, zero-length meta events may be placed between valid events.See MIDI_GetAllEvts.
---@param take MediaItem_Take
---@param buf string
---@return boolean retval
function reaper.MIDI_SetAllEvts(take, buf) end

---Set MIDI CC event properties. Properties passed as NULL will not be set. set noSort if setting multiple events, then call MIDI_Sort when done.
---@param take MediaItem_Take
---@param ccidx integer
---@param selected? boolean
---@param muted? boolean
---@param ppqpos? number
---@param chanmsg? integer
---@param chan? integer
---@param msg2? integer
---@param msg3? integer
---@param noSort? boolean
---@return boolean retval
function reaper.MIDI_SetCC(take, ccidx, selected, muted, ppqpos, chanmsg, chan, msg2, msg3, noSort) end

---Set CC shape and bezier tension. set noSort if setting multiple events, then call MIDI_Sort when done. See MIDI_SetCC, MIDI_GetCCShape
---@param take MediaItem_Take
---@param ccidx integer
---@param shape integer
---@param beztension number
---@param noSort? boolean
---@return boolean retval
function reaper.MIDI_SetCCShape(take, ccidx, shape, beztension, noSort) end

---Set MIDI event properties. Properties passed as NULL will not be set. set noSort if setting multiple events, then call MIDI_Sort when done.
---@param take MediaItem_Take
---@param evtidx integer
---@param selected? boolean
---@param muted? boolean
---@param ppqpos? number
---@param msg? string
---@param noSort? boolean
---@return boolean retval
function reaper.MIDI_SetEvt(take, evtidx, selected, muted, ppqpos, msg, noSort) end

---Set the start/end positions of a media item that contains a MIDI take.
---@param item MediaItem
---@param startQN number
---@param endQN number
---@return boolean retval
function reaper.MIDI_SetItemExtents(item, startQN, endQN) end

---Set MIDI note properties. Properties passed as NULL (or negative values) will not be set. Set noSort if setting multiple events, then call MIDI_Sort when done. Setting multiple note start positions at once is done more safely by deleting and re-inserting the notes.
---@param take MediaItem_Take
---@param noteidx integer
---@param selected? boolean
---@param muted? boolean
---@param startppqpos? number
---@param endppqpos? number
---@param chan? integer
---@param pitch? integer
---@param vel? integer
---@param noSort? boolean
---@return boolean retval
function reaper.MIDI_SetNote(take, noteidx, selected, muted, startppqpos, endppqpos, chan, pitch, vel, noSort) end

---Set MIDI text or sysex event properties. Properties passed as NULL will not be set. Allowable types are -1:sysex (msg should not include bounding F0..F7), 1-14:MIDI text event types, 15=REAPER notation event. set noSort if setting multiple events, then call MIDI_Sort when done.
---@param take MediaItem_Take
---@param textsyxevtidx integer
---@param selected? boolean
---@param muted? boolean
---@param ppqpos? number
---@param type? integer
---@param msg? string
---@param noSort? boolean
---@return boolean retval
function reaper.MIDI_SetTextSysexEvt(take, textsyxevtidx, selected, muted, ppqpos, type, msg, noSort) end

---Sort MIDI events after multiple calls to MIDI_SetNote, MIDI_SetCC, etc.
---@param take MediaItem_Take
function reaper.MIDI_Sort(take) end

---list the takes that are currently being edited in this MIDI editor, starting with the active take. See MIDIEditor_GetTake
---@param midieditor HWND
---@param takeindex integer
---@param editable_only boolean
---@return MediaItem_Take take
function reaper.MIDIEditor_EnumTakes(midieditor, takeindex, editable_only) end

---get a pointer to the focused MIDI editor window
---see MIDIEditor_GetMode, MIDIEditor_OnCommand
---@return HWND hwnd
function reaper.MIDIEditor_GetActive() end

---get the mode of a MIDI editor (0=piano roll, 1=event list, -1=invalid editor)
---see MIDIEditor_GetActive, MIDIEditor_OnCommand
---@param midieditor HWND
---@return integer retval
function reaper.MIDIEditor_GetMode(midieditor) end

---Get settings from a MIDI editor. setting_desc can be:
---    snap_enabled: returns 0 or 1
---    active_note_row: returns 0-127
---    last_clicked_cc_lane: 
---        returns 0-127=CC, 
---                0x100|(0-31)=14-bit CC, 
---                0x200=velocity, 
---                0x201=pitch, 
---                0x202=program, 
---                0x203=channel pressure, 
---                0x204=bank/program select, 
---                0x205=text, 
---                0x206=sysex, 
---                0x207=off velocity, 
---                0x208=notation events, 
---                0x210=media item lane
---    default_note_vel: returns 0-127
---    default_note_chan: returns 0-15
---    default_note_len: returns default length in MIDI ticks
---    scale_enabled: returns 0-1
---    scale_root: returns 0-12 (0=C) 
---    list_cnt: if viewing list view, returns event count  
---    if setting_desc is unsupported, the function returns -1.
---    See MIDIEditor_SetSetting_int, MIDIEditor_GetActive, MIDIEditor_GetSetting_str
---@param midieditor HWND
---@param setting_desc string
---@return integer retval
function reaper.MIDIEditor_GetSetting_int(midieditor, setting_desc) end

---Get settings from a MIDI editor. setting_desc can be:
---last_clicked_cc_lane: returns text description ("velocity", "pitch", etc)
---scale: returns the scale record, for example "102034050607" for a major scale
---list_X: if viewing list view, returns string describing event at row X (0-based). String will have a list of key=value pairs, e.g. 'pos=4.0 len=4.0 offvel=127 msg=90317F'. pos/len times are in QN, len/offvel may not be present if event is not a note. other keys which may be present include pos_pq/len_pq, sel, mute, ccval14, ccshape, ccbeztension.if setting_desc is unsupported, the function returns false.See MIDIEditor_GetActive, MIDIEditor_GetSetting_int
---@param midieditor HWND
---@param setting_desc string
---@return boolean retval, string buf
function reaper.MIDIEditor_GetSetting_str(midieditor, setting_desc) end

---get the take that is currently being edited in this MIDI editorsee MIDIEditor_EnumTakes
---@param midieditor HWND
---@return MediaItem_Take take
function reaper.MIDIEditor_GetTake(midieditor) end

---Send an action command to the last focused MIDI editor. Returns false if there is no MIDI editor open, or if the view mode (piano roll or event list) does not match the input.see MIDIEditor_OnCommand
---@param command_id integer
---@param islistviewcommand boolean
---@return boolean retval
function reaper.MIDIEditor_LastFocused_OnCommand(command_id, islistviewcommand) end

---Send an action command to a MIDI editor. Returns false if the supplied MIDI editor pointer is not valid (not an open MIDI editor).see MIDIEditor_GetActive, MIDIEditor_LastFocused_OnCommand
---@param midieditor HWND
---@param command_id integer
---@return boolean retval
function reaper.MIDIEditor_OnCommand(midieditor, command_id) end

---Set settings for a MIDI editor. setting_desc can be:
---active_note_row: 0-127
---See MIDIEditor_GetSetting_int
---@param midieditor HWND
---@param setting_desc string
---@param setting integer
---@return boolean retval
function reaper.MIDIEditor_SetSetting_int(midieditor, setting_desc, setting) end

---Converts a double-number to its panstr-equivalent.See parsepanstr for its counterpart. 
---@param strNeed64 string
---@param pan number
---@return string strNeed64
function reaper.mkpanstr(strNeed64, pan) end

---creates a vol-pan-string, which holds a readable representation of the vol and pan-values.The format is like "+6.02db center" or "+inf +80R", etcsee [mkpanstr](#mkpanstr) and [mkvolstr](#mkvolstr) for the individual pan/vol-string functions.
---@param strNeed64 string
---@param vol number
---@param pan number
---@return string strNeed64
function reaper.mkvolpanstr(strNeed64, vol, pan) end

---Converts a volume-value into a string-representation of it as dB.Note: Unlike panstr, there is no parsevolstr-string-function available!
---@param strNeed64 string
---@param vol number
---@return string strNeed64
function reaper.mkvolstr(strNeed64, vol) end

---Moves the Edit Cursor.
---@param adjamt number
---@param dosel boolean
function reaper.MoveEditCursor(adjamt, dosel) end

---Moves a MediaItem-object to a specific MediaTrack.Call [UpdateArrange](#UpdateArrange) to update the arrangeview after that.
---@param item MediaItem
---@param desttr MediaTrack
---@return boolean retval
function reaper.MoveMediaItemToTrack(item, desttr) end

---Mutes all tracks
---@param mute boolean
function reaper.MuteAllTracks(mute) end

---With r.??? and sr.??? parameters, you can define coordinates of a rectangle. 
---The function will return the left/top/right/bottom coordinates of the viewport that that rectangle is on/closest to.
---@param r.left integer
---@param r.top integer
---@param r.right integer
---@param r.bot integer
---@param sr.left integer
---@param sr.top integer
---@param sr.right integer
---@param sr.bot integer
---@param wantWorkArea boolean
---@return integer left, integer top, integer right, integer bottom
function reaper.my_getViewport(r.left, r.top, r.right, r.bot, sr.left, sr.top, sr.right, sr.bot, wantWorkArea) end

---Get the command ID number for named command that was registered by an extension such as "\_SWS\_ABOUT" or "\_113088d11ae641c193a2b7ede3041ad5" for a ReaScript or a custom action.see [Main\_OnCommand](#Main_OnCommand) for executing actions with command-ID-numbers.Note: never assume that this command-id is valid across multiple installations. That means, the command-id returned by NamedCommandLookup can be different for the same \_ActionCommandID between different Reaper-installations.
---So when you want to run a command, using the command-id, ALWAYS get it using NamedCommandLookup in your script first, and never store it somewhere to be used later on.
---Otherwise, you risk an action not running.
---This note is important for custom-actions/scripts/actions from extensions.
---The command-ids from Reaper's own actions will always stay the same.
---So rule of thumb: if an action has an action\_command\_id starting with an underscore \_, always use NamedCommandLookup with it.
---@param command_name string
---@return integer retval
function reaper.NamedCommandLookup(command_name) end

---Toggles pause/play during play or pause/rec during recording in the current project.
---When stopped, it will start paused play.
function reaper.OnPauseButton() end

---Toggles pause/play during play or pause/rec during recording in a specific project.
---When stopped, it will start paused play.
---@param proj ReaProject
function reaper.OnPauseButtonEx(proj) end

---Starts playing at edit-cursor. Will stop recording, when executed during recording.
function reaper.OnPlayButton() end

---Starts playing at edit-cursor. Will stop recording, when executed during recording.
---@param proj ReaProject
function reaper.OnPlayButtonEx(proj) end

---Stops playing/recording.
function reaper.OnStopButton() end

---Stops playing/recording.
---@param proj ReaProject
function reaper.OnStopButtonEx(proj) end

---Open a different installed theme.
---@param fn string
---@return boolean retval
function reaper.OpenColorThemeFile(fn) end

---Opens mediafn in the Media Explorer.If you just want to change folder in MediaExplorer, give it a path instead of a file and set play to false.
---@param mediafn string
---@param play boolean
---@return HWND hwnd
function reaper.OpenMediaExplorer(mediafn, play) end

---Send an OSC message directly to REAPER. The value argument may be NULL. The message will be matched against the default OSC patterns.This is not broadcast outside of Reaper, so you can't control devices, plugins, etc with it!Messages sent via this function can be used for parameter-learn/modulation and as shortcuts for scripts.
---The parameter value can be retrieved with the returnvalue val of the function reaper.get_action_context, so sending values to a script is possible that way.
---@param message string
---@param value? number
function reaper.OscLocalMessageToHost(message, value) end

---Parse hh:mm:ss.sss time string, return time in seconds (or 0.0 on error). See [parse\_timestr_pos](#parse_timestr_pos), [parse\_timestr_len](#parse_timestr_len).
---@param buf string
---@return number timestr
function reaper.parse_timestr(buf) end

---Converts a time-string in its time-in-seconds-representationtime formatting mode overrides: -1=proj default.
---0, time
---1, measures.beats + time
---2, measures.beats
---3, seconds
---4, samples
---5, h:m:s:f
---@param buf string
---@param offset number
---@param modeoverride integer
---@return number converted_time
function reaper.parse_timestr_len(buf, offset, modeoverride) end

---Parse time string and convert it into seconds.
---@param buf string
---@param modeoverride integer
---@return number converted_time
function reaper.parse_timestr_pos(buf, modeoverride) end

---Converts a string created by [mkpanstr](#mkpanstr) back to it's double-number.
---@param str string
---@return number retval
function reaper.parsepanstr(str) end

---enumerates the available PCM-sink-formats, which means, the output-formats available in Reaper
---@param idx integer
---@return integer retval, string descstr
function reaper.PCM_Sink_Enum(idx) end

---allows you to retrieve the file-extension of a certain PCM-sink/fileformat available.See [PCM\_Sink\_Enum](#PCM_Sink_Enum) to enumerate available PCM-sink/fileformats.
---@param data string
---@return string extension
function reaper.PCM_Sink_GetExtension(data) end

---@param cfg string
---@param hwndParent HWND
---@return HWND hwnd
function reaper.PCM_Sink_ShowConfig(cfg, hwndParent) end

---The process to build a new peak is to use the modes in a certain order:mode=0 starts the peak-building process(must be done once for this PCM\_Source)
---returned values are: 0, no peaks need to be built; 1, peaks are buildingmode=1 progresses the peak-building a bit each time you call PCM\_Source\_BuildPeaks with mode=1)
---call it repeatedly until it's finished and returns value 0! 
---returned values are: how many percent the peak-building still needs to do until it is finishedmode=2, this finishes up peak-building(call this, when mode=1 returns 0 and only then!)
---returned value is 0
---Running this before mode=1 returns 0 can cause broken peaks shown, until you click into a mediaitem that uses the PCM\_Source.After all peak-building is done, use reaper.UpdateArrange() to show them.Note: All peaks of all takes that use a certain PCM\_Source will be built!Building peaks for multiple PCM\_Sources simultaneously is allowed.
---The following code builds a peak very simply. This is the easiest implementation.
---However, if the PCM\_Source, whose peaks need to be build, is a very long one, this can cause Reaper's UI to hang.
---So use this on short PCM\_Sources mainly.
---        -- Meo-Ada Mespotine - 19th of August 2021 - licensed under MIT-license
---        -- Rebuilt-Peak-Demo without defer, might cause hanging of Reaper's UI        -- Get Item 1, Take 1 and Source of Take 1
---        Item=reaper.GetMediaItem(0,0)
---        Take=reaper.GetMediaItemTake(Item,0)
---        Source=reaper.GetMediaItemTake_Source(Take)        -- start peak-building process(mode must be 0)
---        BuildStart=reaper.PCM_Source_BuildPeaks(Source, 0)        -- build peaks, until PCM_Source_BuildPeaks returns 0(mode must be 1)
---        while BuildProgress~=0 do
---          BuildProgress=reaper.PCM_Source_BuildPeaks(Source, 1)
---        end        -- when build-process is done, finish build-process(mode must be 2)
---        BuildXit=reaper.PCM_Source_BuildPeaks(Source, 2)         -- update the arrangeview, so the newly built peaks are shown
---        reaper.UpdateArrange()
---If you want to build peaks for longer files and maybe showing a status-bar, you can use the following code.
---It uses defer-loops instead of a while-loop.
---As each ReaScript can have up to 1024 defer-loops running at the same time(more or less), I use each of 
---the 1024 defer-loops to build the peak a little further.
---This will prevent hanging UI but might be a little slower than the while-approach.
---        -- Meo-Ada Mespotine - 19th of August 2021 - licensed under MIT-license
---        -- Rebuilt-Peak-Demo using defer, might be a little slower but doesn't 
---        -- cause hanging of Reaper's UI
---        -- 
---        -- set Build_Factor to speed up building process
---        -- allowed values: 0(slow) and 1024(fast)
---        -- Use 1024 only, if you don't have any other defer-loops running.
---        -- If you have other defer-loops that need to be run now, set
---        -- Build_Factor to Build_Factor minus number of running defer-loops.        -- the number of defer-loops used to go through the peak build-process
---        -- the higher, the faster.
---        -- if you use other defer-loops at the time as well, set this lower than 1024 or the other defer-loop will not run
---        Build_Factor=255        -- Get Item 1, Take 1 and Source of Take 1
---        Item=reaper.GetMediaItem(0,0)
---        Take=reaper.GetMediaItemTake(Item,0)
---        Source=reaper.GetMediaItemTake_Source(Take)        -- start build-process of the peak(mode=0)
---        BuildStart=reaper.PCM_Source_BuildPeaks(Source, 0)        function main()
---          -- build peaks, until PCM_Source_BuildPeaks returns 0(mode must be 1)
---          BuildProgress=reaper.PCM_Source_BuildPeaks(Source, 1)
---          
---          if BuildProgress~=0 then 
---            -- if PCM_Source_BuildPeaks returned anything else than 0, defer this function again
---            reaper.defer(main) 
---          else 
---            -- if PCM_Source_BuildPeaks returned 0, finish building of the peaks(mode must be 2)
---            -- and update the arrangeview for the newly built peaks to show
---            BuildXit=reaper.PCM_Source_BuildPeaks(Source, 2) 
---            reaper.UpdateArrange()
---          end
---        end        -- run multiple defer-instances of the peak-build-function
---        for i=0, Build_Factor do
---          main()
---        end
---The following code combines both, defer-loops to cirvumvent possible hanging of Reaper's UI and a loop(for in this case) 
---to build as many small peak-bits and pieces as possible within each defer-loop.
---You can influence the ratio between using defer-loops and for-loops by setting Build\_Factor(defer) and Build\_Progression(for).
---Experiment, how high you can go with the number of for-loops, until Reaper's UI becomes laggy.
---        -- Meo-Ada Mespotine - 19th of August 2021 - licensed under MIT-license
---        -- Rebuilt-Peak-Demo defer and a regular for-loop combined, doesn't 
---        -- cause hanging of Reaper's UI
---        -- 
---        -- set Build_Factor to speed up building process
---        -- allowed values: 0(slow) and 1024(fast)
---        -- Use 1024 only, if you don't have any other defer-loops running.
---        -- If you have other defer-loops that need to be run now, set
---        -- Build_Factor to Build_Factor minus number of running defer-loops.        -- build-speed factors
---        Build_Factor=255     -- set to the number of defer-loops used
---        Build_Progression=20 -- set to the number of peak-building-bits built within each defer-loop        -- Get Item 1, Take 1 and Source of Take 1
---        Item=reaper.GetMediaItem(0,0)
---        Take=reaper.GetMediaItemTake(Item,0)
---        Source=reaper.GetMediaItemTake_Source(Take)        -- start build-process of the peak(mode=0)
---        BuildStart=reaper.PCM_Source_BuildPeaks(Source,0)        function main()
---          -- build peaks, until PCM_Source_BuildPeaks returns 0(mode must be 1)
---          -- do it for Build_Progression-times within this defer-loop.
---          for i=0, Build_Progression do
---            BuildProgress=reaper.PCM_Source_BuildPeaks(Source,1)
---          end
---          
---          if BuildProgress~=0 then 
---            -- if PCM_Source_BuildPeaks returned anything else than 0, defer this function again
---            reaper.defer(main) 
---          else 
---            -- if PCM_Source_BuildPeaks returned 0, finish building of the peaks(mode must be 2)
---            -- and update the arrangeview for the newly built peaks to show
---            BuildXit=reaper.PCM_Source_BuildPeaks(Source,2) 
---            reaper.UpdateArrange()
---          end
---        end
---        -- run multiple defer-instances of the peak-build-function
---        for i=0, Build_Factor do
---          main()
---        end
---@param src PCM_source
---@param mode integer
---@return integer retval
function reaper.PCM_Source_BuildPeaks(src, mode) end

---See [PCM\_Source\_CreateFromFileEx](#PCM_Source_CreateFromFileEx).
---@param filename string
---@return PCM_source src
function reaper.PCM_Source_CreateFromFile(filename) end

---Create a PCM_source from filename, and override pref of MIDI files being imported as in-project MIDI events.
---@param filename string
---@param forcenoMidiImp boolean
---@return PCM_source src
function reaper.PCM_Source_CreateFromFileEx(filename, forcenoMidiImp) end

---Create a PCM_source from a "type" (use this if you're going to load its state via LoadState/ProjectStateContext).
---Valid types include "WAVE", "MIDI", or whatever plug-ins define as well.
---@param sourcetype string
---@return PCM_source src
function reaper.PCM_Source_CreateFromType(sourcetype) end

---Deletes a PCM_source -- be sure that you remove any project reference before deleting a source
---@param src PCM_source
function reaper.PCM_Source_Destroy(src) end

---Gets block of peak samples to buf. Note that the peak samples are interleaved, but in two or three blocks (maximums, then minimums, then extra). 
---Return value has 20 bits of returned sample count, then 4 bits of output_mode (0xf00000), then a bit to signify whether extra_type was available (0x1000000). 
---extra_type can be 115 ('s') for spectral information, which will return peak samples as integers with the low 15 bits frequency, next 14 bits tonality.
---@param src PCM_source
---@param peakrate number
---@param starttime number
---@param numchannels integer
---@param numsamplesperchannel integer
---@param want_extra_type integer
---@param buf reaper.array
---@return integer retval
function reaper.PCM_Source_GetPeaks(src, peakrate, starttime, numchannels, numsamplesperchannel, want_extra_type, buf) end

---If a section/reverse block, retrieves offset/len/reverse. return true if success
---@param src PCM_source
---@return boolean retval, number offs, number len, boolean rev
function reaper.PCM_Source_GetSectionInfo(src) end

---@param amt integer
function reaper.PluginWantsAlwaysRunFx(amt) end

---adds prevent_count to the UI refresh prevention state; Important: always add then remove the same amount, or major disfunction will occur
---It's important to add first and remove second, as other functions you use inbetween might
---change this counter as well.
---If you remove first and then add later, UI-refresh might be turned on again by another function used
---causing unwanted flicker!
---
---@param prevent_count integer
function reaper.PreventUIRefresh(prevent_count) end

---Opens the actionlist and allows you to get, which action the user selected.So the user can select numerous actions, and when they hit the select or select/close-button, you can get the actions selected.To start a new session, pass 1 as parameter session_mode.After that, repeatedly call the function with session_mode=0, which will return the selected actions.
---        - -1, the actionlist is closed
---        - 0, no action has been selected
---        - any other number, this action has been selected.
---In the latter case, call the function until it returns 0 again to get all selected actions.If you're finished, call the function with session_mode=-1
---When finished, call with session_mode=-1.
---@param session_mode integer
---@param init_id integer
---@param section_id integer
---@return integer retval
function reaper.PromptForAction(session_mode, init_id, section_id) end

---Causes REAPER to display the error message after the current ReaScript finishes. If called within a Lua context and errmsg has a ! prefix, script execution will be terminated.
---@param errmsg string
function reaper.ReaScriptError(errmsg) end

---Creates a new directory. You can recursivly create directories, means: if the higher directories don't exist, the will also be automatically created.returns positive value on success, 0 on failure.
---@param path string
---@param ignored integer
---@return integer retval
function reaper.RecursiveCreateDirectory(path, ignored) end

---garbage-collects extra open files and closes them. if flags has 1 set, this is done incrementally (call this from a regular timer, if desired). if flags has 2 set, files are aggressively closed (they may need to be re-opened very soon). returns number of files closed by this call.
---@param flags integer
---@return integer retval
function reaper.reduce_open_files(flags) end

---Refreshes the toolbar-buttons, associated with a specific command_id/actionsee [NamedCommandLookup](#NamedCommandLookup) for getting command-ids from scripts and 3rd-party actionsSee [RefreshToolbar2](#RefreshToolbar2).
---@param command_id integer
function reaper.RefreshToolbar(command_id) end

---Refreshes the toolbar-buttons, associated with a specific command_id/action within a certain sectionsee [NamedCommandLookup](#NamedCommandLookup) for getting command-ids from scripts and 3rd-party actions
---@param section_id integer
---@param command_id integer
function reaper.RefreshToolbar2(section_id, command_id) end

---Makes a filename "in" relative to the current project, if any.
---@param in_ string
---@param out string
---@return string out
function reaper.relative_fn(in_, out) end

---Remove a send/receive/hardware output.For ReaRoute-users: the outputs are hardware outputs, but with 512 added to the destination channel index (512 is the first rearoute channel, 513 the second, etc).
---@param tr MediaTrack
---@param category integer
---@param sendidx integer
---@return boolean retval
function reaper.RemoveTrackSend(tr, category, sendidx) end

---Not available while playing back.
---@param source_filename string
---@param target_filename string
---@param start_percent number
---@param end_percent number
---@param playrate number
---@return boolean retval
function reaper.RenderFileSection(source_filename, target_filename, start_percent, end_percent, playrate) end

---Moves all selected tracks to immediately above track specified by index beforeTrackIdx, returns false if no tracks were selected. 
---makePrevFolder=0 for normal, 
---   1 = as child of track preceding track specified by beforeTrackIdx, 
---   2 = if track preceding track specified by beforeTrackIdx is last track in folder, extend folder
---@param beforeTrackIdx integer
---@param makePrevFolder integer
---@return boolean retval
function reaper.ReorderSelectedTracks(beforeTrackIdx, makePrevFolder) end

---enumerates the existing resample-modes
---@param mode integer
---@return string resample_mode
function reaper.Resample_EnumModes(mode) end

---See [resolve\_fn2](#resolve_fn2).
---@param in_ string
---@param out string
---@return string out
function reaper.resolve_fn(in_, out) end

---Resolves a filename "in" by using project settings etc. If no file found, out will be a copy of in.
---@param in_ string
---@param out string
---@param checkSubDir? string
---@return string out
function reaper.resolve_fn2(in_, out, checkSubDir) end

---Get the named command for the given command ID. The returned string will not start with '_' (e.g. it will return "SWS_ABOUT"), it will be NULL if command_id is a native action.
---@param command_id integer
---@return string action_command_id
function reaper.ReverseNamedCommandLookup(command_id) end

---See [GetEnvelopeScalingMode](#GetEnvelopeScalingMode).
---@param scaling_mode integer
---@param val number
---@return number retval
function reaper.ScaleFromEnvelopeMode(scaling_mode, val) end

---See [GetEnvelopeScalingMode](#GetEnvelopeScalingMode).
---@param scaling_mode integer
---@param val number
---@return number retval
function reaper.ScaleToEnvelopeMode(scaling_mode, val) end


---Selects or deselects all MediaItems in a project.
---@param proj ReaProject
---@param selected boolean
function reaper.SelectAllMediaItems(proj, selected) end

---Switch to another opened project/projecttab.
---@param proj ReaProject
function reaper.SelectProjectInstance(proj) end

---Sends a MIDI message to output device specified by output. Message is sent in immediate mode.
---@param output integer
---@param msg string
function reaper.SendMIDIMessageToHardware(output, msg) end

---set this take active in this media item
---@param take MediaItem_Take
function reaper.SetActiveTake(take) end

---Sets all or selected tracks to mode.Includes the master-track.
---@param mode integer
---@param onlySel boolean
function reaper.SetAutomationMode(mode, onlySel) end

---set current BPM in project, set wantUndo=true to add undo point
---@param proj ReaProject
---@param bpm number
---@param wantUndo boolean
function reaper.SetCurrentBPM(proj, bpm, wantUndo) end

---Change the focus for the cursor.
---You must use this to change the focus for the cursor programmatically. mode=0 to focus track panels, 1 to focus the arrange window, 2 to focus the arrange window and select env (or env==NULL to clear the current track/take envelope selection)
---@param mode integer
---@param env TrackEnvelope
function reaper.SetCursorContext(mode, env) end

---Change the position of the edit-cursor in the current project.
---@param time number
---@param moveview boolean
---@param seekplay boolean
function reaper.SetEditCurPos(time, moveview, seekplay) end

---Change the position of the edit-cursor in a specific project.
---@param proj ReaProject
---@param time number
---@param moveview boolean
---@param seekplay boolean
function reaper.SetEditCurPos2(proj, time, moveview, seekplay) end

---Set attributes of an envelope point. Values that are not supplied will be ignored. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done. See [SetEnvelopePointEx](#SetEnvelopePointEx).
---@param envelope TrackEnvelope
---@param ptidx integer
---@param time? number
---@param value? number
---@param shape? integer
---@param tension? number
---@param selected? boolean
---@param noSort? boolean
---@return boolean retval
function reaper.SetEnvelopePoint(envelope, ptidx, time, value, shape, tension, selected, noSort) end

---Set attributes of an envelope point. Values that are not supplied will be ignored. If setting multiple points at once, set noSort=true, and call Envelope_SortPoints when done.
---autoitem\_idx=-1 for the underlying envelope, 0 for the first automation item on the envelope, etc.
---For automation items, pass autoitem\_idx|0x10000000 to base ptidx on the number of points in one full loop iteration,
---even if the automation item is trimmed so that not all points are visible.
---Otherwise, ptidx will be based on the number of visible points in the automation item, including all loop iterations.
---See [CountEnvelopePointsEx](#CountEnvelopePointsEx), [GetEnvelopePointEx](#GetEnvelopePointEx), [InsertEnvelopePointEx](#InsertEnvelopePointEx), [DeleteEnvelopePointEx](#DeleteEnvelopePointEx).
---@param envelope TrackEnvelope
---@param autoitem_idx integer
---@param ptidx integer
---@param time? number
---@param value? number
---@param shape? integer
---@param tension? number
---@param selected? boolean
---@param noSort? boolean
---@return boolean retval
function reaper.SetEnvelopePointEx(envelope, autoitem_idx, ptidx, time, value, shape, tension, selected, noSort) end

---Sets the RPPXML state of an envelope, returns true if successful. 
---@param env TrackEnvelope
---@param str string
---@param isundo boolean
---@return boolean retval
function reaper.SetEnvelopeStateChunk(env, str, isundo) end

---Set the extended state value for a specific section and key. Persistant states are stored into the reaper-extstate.ini in the resources-folder.Note: section and key are not case-sensitiveImportant: always use a section-name, that is unique to you. For instance, add your name into the section-name, 
---so it's less likely, that somebody else uses the same section and accidentally overwrites your keys.
---Something like: "mespotine_MyCoolScript.lua"Note: Do not use newlines in extstates, as they might be cut when rereading them using GetExtState!
---      Find workarounds, like \n -> \\n to store and \\n -> \n to get them again.
---      This is due limitations of the ini-file-format.
---      
---      
---Here are some of the sections used by ReaTeam-scripts and extensions. Don't use to avoid possible name-conflicts.
---If your section is missing, contact me and I'll add it too:"_Slicer_"
---"(Un)Collapse envelope lanes"
---"+"
---"amagalma_Chunk Viewer-Editor"
---"amagalma_Grid Settings"
---"amagalma_Horizontal zoom presets"
---"amagalma_NormalizeTracks"
---"amagalma_Take_Vol_in_TS"
---"amagalma_Vertical zoom presets"
---"amagalma_backup_limit"
---"APIhelp"
---"babag_copy_paste_item_params"
---"BR_SPK_GlueTools"
---"brso_articulate"
---"BuyOne_Check length of custom action(s).lua"
---"BuyOne_Cycle through focused FX presets backwards (guide inside).lua"
---"BuyOne_Cycle through focused FX presets forward (guide inside).lua"
---"BuyOne_Exclusive dummy toggle"
---"BuyOne_Exclusive dummy toggles.lua"
---"BuyOne_Link two FX parameters via parameter modulation (guide inside).lua"
---"cfillion_copy_paste_markers"
---"cfillion_ireascript"
---"cfillion_ramp_envelope_points"
---"cfillion_show_nudge_settings"
---"cfillion_song_switcher"
---"cfillion_stepRecordReplace"
---"cfillion_underrun_monitor"
---"colswatch"
---"com.timtam.AccessiChord"
---"cool_MK Slicer.lua"
---"cool_MK_Shaper/Stutter.lua"
---"copy_paste"
---"Default_6.0 theme adjuster"
---"Dfk Project Map"
---"Edgemeal_fx_float"
---"Edit Groups"
---"GoToTimecode_AZ"
---"js_Draw LFO"
---"js_Draw ramp"
---"js_Insert ramps"
---"js_Mouse actions"
---"js_Mouse actions"
---"js_Multi Tool"
---"js_Step pattern"
---"js_Thumbnails"
---"LFO generator"
---"Lokasenna"
---"Lokasenna's Script Compiler"
---"Lokasenna's Theory Helper"
---"Lokasenna_CC Ryder"
---"Lokasenna_Copy values from selected MIDI notes"
---"Lokasenna_Debug mode"
---"Lokasenna_GUI"
---"Lokasenna_Pedal Steel"
---"Mespotine"
---"MFX-list"
---"MIDI Inspector"
---"MK Slicer (80icio MOD).lua"
---"osara"
---"Play-Stop with memory"
---"Preset Velocity"
---"RODILAB_Color_palette"
---"RODILAB_Match_criteria"
---"RODILAB_Track_name_groups"
---"ReaL_Comps"
---"ReaNoir"
---"savegrid"
---"Select CC lanes to show"
---"SmartSplit_AZ"
---"solger_ReaLauncher"
---"Source time position v2"
---"spk77_velocity_tool"
---"take_envelope_source"
---"talagan_Distribute MIDI notes evenly"
---"ToggleWet"
---"Track-Item Name Manipulation"
---"ultraschall_api"
---"vo_pomodoro"
---@param section string
---@param key string
---@param value string
---@param persist boolean
function reaper.SetExtState(section, key, value, persist) end

---mode: see [GetGlobalAutomationOverride](GetGlobalAutomationOverride)
---@param mode integer
function reaper.SetGlobalAutomationOverride(mode) end

---Sets the RPPXML state of an item, returns true if successful. Undo flag is a performance/caching hint.
---@param item MediaItem
---@param str string
---@param isundo boolean
---@return boolean retval
function reaper.SetItemStateChunk(item, str, isundo) end

---set &1=1 to show the master track in the TCP, &2=2 to hide in the mixer. Returns the previous visibility state. See [GetMasterTrackVisibility](#GetMasterTrackVisibility).
---@param flag integer
---@return integer mas_prev_vis_state
function reaper.SetMasterTrackVisibility(flag) end

---Set media item numerical-value attributes.
---B_MUTE : bool * : muted
---B_MUTE_ACTUAL : bool * : muted (ignores solo). setting this value will not affect C_MUTE_SOLO.
---C_MUTE_SOLO : char * : solo override (-1=soloed, 0=no override, 1=unsoloed). note that this API does not automatically unsolo other items when soloing (nor clear the unsolos when clearing the last soloed item), it must be done by the caller via action or via this API.
---B_LOOPSRC : bool * : loop source
---B_ALLTAKESPLAY : bool * : all takes play
---B_UISEL : bool * : selected in arrange view
---C_BEATATTACHMODE : char * : item timebase, -1=track or project default, 1=beats (position, length, rate), 2=beats (position only). for auto-stretch timebase: C_BEATATTACHMODE=1, C_AUTOSTRETCH=1
---C_AUTOSTRETCH: : char * : auto-stretch at project tempo changes, 1=enabled, requires C_BEATATTACHMODE=1
---C_LOCK : char * : locked, &1=locked, &2=lock to active take
---D_VOL : double * : item volume, 0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc
---D_POSITION : double * : item position in seconds
---D_LENGTH : double * : item length in seconds
---D_SNAPOFFSET : double * : item snap offset in seconds
---D_FADEINLEN : double * : item manual fadein length in seconds
---D_FADEOUTLEN : double * : item manual fadeout length in seconds
---D_FADEINDIR : double * : item fadein curvature, -1..1
---D_FADEOUTDIR : double * : item fadeout curvature, -1..1
---D_FADEINLEN_AUTO : double * : item auto-fadein length in seconds, -1=no auto-fadein
---D_FADEOUTLEN_AUTO : double * : item auto-fadeout length in seconds, -1=no auto-fadeout
---C_FADEINSHAPE : int * : fadein shape, 0..6, 0=linear
---C_FADEOUTSHAPE : int * : fadeout shape, 0..6, 0=linear
---I_GROUPID : int * : group ID, 0=no group
---I_LASTY : int * : Y-position (relative to top of track) in pixels (read-only)
---I_LASTH : int * : height in pixels (read-only)
---I_CUSTOMCOLOR : int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). If you do not |0x1000000, then it will not be used, but will store the color.
---I_CURTAKE : int * : active take number
---IP_ITEMNUMBER : int : item number on this track (read-only, returns the item number directly)
---F_FREEMODE_Y : float * : free item positioning Y-position, 0=top of track, 1=bottom of track (will never be 1)
---F_FREEMODE_H : float * : free item positioning height, 0=no height, 1=full height of track (will never be 0)
---@param item MediaItem
---@param parmname string
---@param newvalue number
---@return boolean retval
function reaper.SetMediaItemInfo_Value(item, parmname, newvalue) end

---Redraws the screen only if refreshUI == true, otherwise see [UpdateArrange](#UpdateArrange)().
---@param item MediaItem
---@param length number
---@param refreshUI boolean
---@return boolean retval
function reaper.SetMediaItemLength(item, length, refreshUI) end

---Redraws the screen only if refreshUI == true.
---See [UpdateArrange](#UpdateArrange)().
---@param item MediaItem
---@param position number
---@param refreshUI boolean
---@return boolean retval
function reaper.SetMediaItemPosition(item, position, refreshUI) end

---Sets a mediaitem selected or unselected.Use [UpdateArrange](#UpdateArrange)() to make changes visible.
---@param item MediaItem
---@param selected boolean
function reaper.SetMediaItemSelected(item, selected) end

---Set media source of media item take. The old source will not be destroyed, it is the caller's responsibility to retrieve it and destroy it after. If source already exists in any project, it will be duplicated before being set. C/C++ code should not use this and instead use GetSetMediaItemTakeInfo() with P_SOURCE to manage ownership directly.
---@param take MediaItem_Take
---@param source PCM_source
---@return boolean retval
function reaper.SetMediaItemTake_Source(take, source) end

---Set media item take numerical-value attributes.
---D_STARTOFFS : double * : start offset in source media, in seconds
---D_VOL : double * : take volume, 0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc, negative if take polarity is flipped
---D_PAN : double * : take pan, -1..1
---D_PANLAW : double * : take pan law, -1=default, 0.5=-6dB, 1.0=+0dB, etc
---D_PLAYRATE : double * : take playback rate, 0.5=half speed, 1=normal, 2=double speed, etc
---D_PITCH : double * : take pitch adjustment in semitones, -12=one octave down, 0=normal, +12=one octave up, etc
---B_PPITCH : bool * : preserve pitch when changing playback rate
---I_LASTY : int * : Y-position (relative to top of track) in pixels (read-only)
---I_LASTH : int * : height in pixels (read-only)
---I_CHANMODE : int * : channel mode, 0=normal, 1=reverse stereo, 2=downmix, 3=left, 4=right
---I_PITCHMODE : int * : pitch shifter mode, -1=projext default, otherwise high 2 bytes=shifter, low 2 bytes=parameter
---I_CUSTOMCOLOR : int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). If you do not |0x1000000, then it will not be used, but will store the color.
---IP_TAKENUMBER : int : take number (read-only, returns the take number directly)
---@param take MediaItem_Take
---@param parmname string
---@param newvalue number
---@return boolean retval
function reaper.SetMediaItemTakeInfo_Value(take, parmname, newvalue) end

---Set track numerical-value attributes.
---B_MUTE : bool * : muted
---B_PHASE : bool * : track phase inverted
---B_RECMON_IN_EFFECT : bool * : record monitoring in effect (current audio-thread playback state, read-only)
---IP_TRACKNUMBER : int : track number 1-based, 0=not found, -1=master track (read-only, returns the int directly)
---I_SOLO : int * : soloed, 0=not soloed, 1=soloed, 2=soloed in place, 5=safe soloed, 6=safe soloed in place
---B_SOLO_DEFEAT : bool * : when set, if anything else is soloed and this track is not muted, this track acts soloed
---I_FXEN : int * : fx enabled, 0=bypassed, !0=fx active
---I_RECARM : int * : record armed, 0=not record armed, 1=record armed
---I_RECINPUT : int * : record input, <0=no input. if 4096 set, input is MIDI and low 5 bits represent channel (0=all, 1-16=only chan), next 6 bits represent physical input (63=all, 62=VKB). If 4096 is not set, low 10 bits (0..1023) are input start channel (ReaRoute/Loopback start at 512). If 2048 is set, input is multichannel input (using track channel count), or if 1024 is set, input is stereo input, otherwise input is mono.
---I_RECMODE : int * : record mode, 0=input, 1=stereo out, 2=none, 3=stereo out w/latency compensation, 4=midi output, 5=mono out, 6=mono out w/ latency compensation, 7=midi overdub, 8=midi replace
---I_RECMODE_FLAGS : int * : record mode flags, &3=output recording mode (0=post fader, 1=pre-fx, 2=post-fx/pre-fader)
---I_RECMON : int * : record monitoring, 0=off, 1=normal, 2=not when playing (tape style)
---I_RECMONITEMS : int * : monitor items while recording, 0=off, 1=on
---B_AUTO_RECARM : bool * : automatically set record arm when selected (does not immediately affect recarm state, script should set directly if desired)
---I_VUMODE : int * : track vu mode, &1:disabled, &30==0:stereo peaks, &30==2:multichannel peaks, &30==4:stereo RMS, &30==8:combined RMS, &30==12:LUFS-M, &30==16:LUFS-S (readout=max), &30==20:LUFS-S (readout=current), &32:LUFS calculation on channels 1+2 only
---I_AUTOMODE : int * : track automation mode, 0=trim/off, 1=read, 2=touch, 3=write, 4=latch
---I_NCHAN : int * : number of track channels, 2-64, even numbers only
---I_SELECTED : int * : track selected, 0=unselected, 1=selected
---I_WNDH : int * : current TCP window height in pixels including envelopes (read-only)
---I_TCPH : int * : current TCP window height in pixels not including envelopes (read-only)
---I_TCPY : int * : current TCP window Y-position in pixels relative to top of arrange view (read-only)
---I_MCPX : int * : current MCP X-position in pixels relative to mixer container (read-only)
---I_MCPY : int * : current MCP Y-position in pixels relative to mixer container (read-only)
---I_MCPW : int * : current MCP width in pixels (read-only)
---I_MCPH : int * : current MCP height in pixels (read-only)
---I_FOLDERDEPTH : int * : folder depth change, 0=normal, 1=track is a folder parent, -1=track is the last in the innermost folder, -2=track is the last in the innermost and next-innermost folders, etc
---I_FOLDERCOMPACT : int * : folder compacted state (only valid on folders), 0=normal, 1=small, 2=tiny children
---I_MIDIHWOUT : int * : track midi hardware output index, <0=disabled, low 5 bits are which channels (0=all, 1-16), next 5 bits are output device index (0-31)
---I_PERFFLAGS : int * : track performance flags, &1=no media buffering, &2=no anticipative FX
---I_CUSTOMCOLOR : int * : custom color, OS dependent color|0x1000000 (i.e. ColorToNative(r,g,b)|0x1000000). 0, default color. If you do not |0x1000000, then it will not be used, but will store the color
---I_HEIGHTOVERRIDE : int * : custom height override for TCP window, 0 for none, otherwise size in pixels
---B_HEIGHTLOCK : bool * : track height lock (must set I_HEIGHTOVERRIDE before locking)
---D_VOL : double * : trim volume of track, 0=-inf, 0.5=-6dB, 1=+0dB, 2=+6dB, etc
---D_PAN : double * : trim pan of track, -1..1
---D_WIDTH : double * : width of track, -1..1
---D_DUALPANL : double * : dualpan position 1, -1..1, only if I_PANMODE==6
---D_DUALPANR : double * : dualpan position 2, -1..1, only if I_PANMODE==6
---I_PANMODE : int * : pan mode, 0=classic 3.x, 3=new balance, 5=stereo pan, 6=dual pan
---D_PANLAW : double * : pan law of track, <0=project default, 0.5=-6dB, 0.707..=-3dB, 1=+0dB, 1.414..=-3dB with gain compensation, 2=-6dB with gain compensation, etc
---I_PANLAW_FLAGS : int * : pan law flags, 0=sine taper, 1=hybrid taper with deprecated behavior when gain compensation enabled, 2=linear taper, 3=hybrid taper
---P_ENV:<envchunkname or P_ENV:{GUID... : TrackEnvelope* : read only. Chunkname can be <VOLENV, <PANENV, etc; GUID is the stringified envelope GUID.
---B_SHOWINMIXER : bool * : track control panel visible in mixer (do not use on master track)
---B_SHOWINTCP : bool * : track control panel visible in arrange view (do not use on master track)
---B_MAINSEND : bool * : track sends audio to parent
---C_MAINSEND_OFFS : char * : channel offset of track send to parent
---C_MAINSEND_NCH : char * : channel count of track send to parent (0=use all child track channels, 1=use one channel only)
---I_FREEMODE : int * : 1=track free item positioning enabled, 2=track fixed lanes enabled (call UpdateTimeline() after changing)
---C_BEATATTACHMODE : char * : track timebase, -1=project default, 0=time, 1=beats (position, length, rate), 2=beats (position only)
---F_MCP_FXSEND_SCALE : float * : scale of fx+send area in MCP (0=minimum allowed, 1=maximum allowed)
---F_MCP_FXPARM_SCALE : float * : scale of fx parameter area in MCP (0=minimum allowed, 1=maximum allowed)
---F_MCP_SENDRGN_SCALE : float * : scale of send area as proportion of the fx+send total area (0=minimum allowed, 1=maximum allowed)
---F_TCP_FXPARM_SCALE : float * : scale of TCP parameter area when TCP FX are embedded (0=min allowed, default, 1=max allowed)
---I_PLAY_OFFSET_FLAG : int * : track media playback offset state, &1=bypassed, &2=offset value is measured in samples (otherwise measured in seconds)
---D_PLAY_OFFSET : double * : track media playback offset, units depend on I_PLAY_OFFSET_FLAG
---@param tr MediaTrack
---@param parmname string
---@param newvalue number
---@return boolean retval
function reaper.SetMediaTrackInfo_Value(tr, parmname, newvalue) end

---Set the MIDI editor grid division. 0.25=quarter note, 1.0/3.0=half note tripet, etc.
---@param project ReaProject
---@param division number
function reaper.SetMIDIEditorGrid(project, division) end

---Scroll the mixer so that leftmosttrack is the leftmost visible track. Returns the leftmost track after scrolling, which may be different from the passed-in track if there are not enough tracks to its right.
---@param leftmosttrack MediaTrack
---@return MediaTrack tr
function reaper.SetMixerScroll(leftmosttrack) end

---Set the mouse modifier assignment for a specific modifier key assignment, in a specific context.Context is a string like "MM\_CTX\_ITEM". Find these strings by modifying an assignment in 
---Preferences/Editing/Mouse Modifiers, then looking in reaper-mouse.ini.Modifier flag is a number from 0 to 15: add 1 for shift, 2 for control, 4 for alt, 8 for win.
---(macOS: add 1 for shift, 2 for command, 4 for opt, 8 for control.)For left-click and double-click contexts, the action can be any built-in command ID number
---or any custom action ID string. Find built-in command IDs in the REAPER actions window
---(enable "show action IDs" in the context menu), and find custom action ID strings in reaper-kb.ini.For built-in mouse modifier behaviors, find action IDs (which will be low numbers)
---by modifying an assignment in Preferences/Editing/Mouse Modifiers, then looking in reaper-mouse.ini.
---Assigning an action of -1 will reset that mouse modifier behavior to factory default.
---See [GetMouseModifier](#GetMouseModifier).Note: the action string may have a space and 'c' or 'm' appended to it to specify command ID vs mouse modifier ID.
---Special case: SetMouseModifier(context, -1, -1) will reset the entire context to default.
---Special case: SetMouseModifier(-1, -1, -1) will reset all contexts to default.See [Docs for reaper-mouse.ini](Reaper-Filetype-Descriptions.html#Reaper-mouse.ini) for more details
---@param context string
---@param modifier_flag integer
---@param action string
function reaper.SetMouseModifier(context, modifier_flag, action) end

---Set exactly one track selected, deselect all others.This sets the track as Last-Touched-Track as well.
---@param track MediaTrack
function reaper.SetOnlyTrackSelected(track) end

---Set the arrange view grid division. 0.25=quarter note, 1.0/3.0=half note triplet, etc.
---@param project ReaProject
---@param division number
function reaper.SetProjectGrid(project, division) end

---Sets/alters an existing project-markerNote: this function can't clear a marker's name (an empty string will leave the name unchanged), see SetProjectMarker4.
---@param markrgnindexnumber integer
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param name string
---@return boolean retval
function reaper.SetProjectMarker(markrgnindexnumber, isrgn, pos, rgnend, name) end

---Sets/alters an existing project-marker in a given project.Note: this function can't clear a marker's name (an empty string will leave the name unchanged), see SetProjectMarker4.
---@param proj ReaProject
---@param markrgnindexnumber integer
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param name string
---@return boolean retval
function reaper.SetProjectMarker2(proj, markrgnindexnumber, isrgn, pos, rgnend, name) end

---Sets/alters an existing project-marker in a given project. Differs from SetProjectMarker2 and SetProjectMarker, that you can set color as well.
---Color should be 0 to not change, or ColorToNative(r,g,b)|0x1000000set color=1&~0x10000000 to reset to default color for markers/regionsNote: this function can't clear a marker's name (an empty string will leave the name unchanged), see SetProjectMarker4.
---@param proj ReaProject
---@param markrgnindexnumber integer
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param name string
---@param color integer
---@return boolean retval
function reaper.SetProjectMarker3(proj, markrgnindexnumber, isrgn, pos, rgnend, name, color) end

---Sets/alters an existing project-marker in a given project.
---color should be 0 to not change, or ColorToNative(r,g,b)|0x1000000, flags&1 to clear nameset color=1&~0x10000000 to reset to default color for markers/regions
---@param proj ReaProject
---@param markrgnindexnumber integer
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param name string
---@param color integer
---@param flags integer
---@return boolean retval
function reaper.SetProjectMarker4(proj, markrgnindexnumber, isrgn, pos, rgnend, name, color, flags) end

---set color=1&~0x10000000 to reset to default color for markers/regions
---@param proj ReaProject
---@param markrgnidx integer
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param IDnumber integer
---@param name string
---@param color integer
---@return boolean retval
function reaper.SetProjectMarkerByIndex(proj, markrgnidx, isrgn, pos, rgnend, IDnumber, name, color) end

---Differs from SetProjectMarker4 in that markrgnidx is 0 for the first marker/region, 1 for the next, etc, rather than representing the displayed marker/region ID number (see [SetProjectMarker3](#SetProjectMarker3)). Function will fail if attempting to set a duplicate ID number for a region (duplicate ID numbers for markers are OK).flags&1 to clear name
---flags&2, markers will not be re-sorted, and after making updates, you MUST call SetProjectMarkerByIndex2 with markrgnidx=-1 and flags&2 to force re-sort/UI updates.set color=1&~0x10000000 to reset to default color for markers/regions
---@param proj ReaProject
---@param markrgnidx integer
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param IDnumber integer
---@param name string
---@param color integer
---@param flags integer
---@return boolean retval
function reaper.SetProjectMarkerByIndex2(proj, markrgnidx, isrgn, pos, rgnend, IDnumber, name, color, flags) end

---Save a key/value pair for a specific extension, to be restored the next time this specific project is loaded. Typically extname will be the name of a reascript or extension section. If key is NULL or "", all extended data for that extname will be deleted. If val is NULL or "", the data previously associated with that key will be deleted. Returns the size of the state for this extname. Important: if you want to store binary data, \0-bytes (Null-bytes) cause trouble. Everything after the first \0-byte will be cut off when reading the extstate via GetProjExtState.
---If you want to store data including \0-bytes, convert them first into a Hex-string or Base64 and decode them after reading it back.
---That way, you can be sure, the data stays intact.Also Important: always use a section-name, that is unique to you. For instance, add your name into the section-name, 
---so it's less likely, that somebody else uses the same section and accidentally overwrites your keys.
---Something like: "mespotine_MyCoolScript.lua"Here are some of the sections used by ReaTeam-scripts and extensions. Don't use to avoid possible name-conflicts.
---If your section is missing, contact me and I'll add it too:
---    "ABLM2 Toggle"
---    "AB_LM Toggle"
---    "ak5k"
---    "ak5k_Drums to MIDI"
---    "com.pandabot.ChordGun"
---    "com.pandabot.CopyAndPasteRhythm""
---    "com.pandabot.selectEveryNItemsWithinSelection"
---    "com.pandabot.selectEveryNNotesWithinSelection"
---    "com.pandabot.selectEveryNTracksWithinSelection"
---    "com.timtam.AccessiChord"
---    "Edit Groups"
---    "FindReplaceStorage"
---    "js_Thumbnails"
---    "LFO Generator"
---    "Live_Inst_"
---    "practice_coach"
---    "RODILAB_Hide_tracks_with_no_items_in_time_selection"
---    "RODILAB_Track_name_groups"
---    "ReaL_Comps"
---    "RegionRenderMatrixState"
---    "Smart Zoom"
---    "spk77 Track Tags"
---    "TrackBasedItems"
---    "time"
---@param proj ReaProject
---@param extname string
---@param key string
---@param value string
---@return integer retval
function reaper.SetProjExtState(proj, extname, key, value) end

---Add (flag > 0) or remove (flag < 0) a track from this region when using the region render matrix. If adding, flag==2 means force mono, flag==4 means force stereo, flag==N means force N/2 channels.see TrackList_AdjustWindows to refresh the region-render-matrix
---@param proj ReaProject
---@param regionindex integer
---@param track MediaTrack
---@param addorremove integer
function reaper.SetRegionRenderMatrix(proj, regionindex, track, addorremove) end

---Inserts or updates a take marker. If idx<0, a take marker will be added, otherwise an existing take marker will be updated. Returns the index of the new or updated take marker (which may change if srcPos is updated).When inserting a new takemarker, parameter srcpos must be given!
---@param take MediaItem_Take
---@param idx integer
---@param name string
---@param srcpos? number
---@param color? integer
---@return integer index
function reaper.SetTakeMarker(take, idx, name, srcpos, color) end

---Adds or updates a stretch marker. If idx>0, stretch marker will be added. If idx>=0, stretch marker will be updated. When adding, if srcpos Optional is omitted, source position will be auto-calculated. When updating a stretch marker, if srcpos Optional is omitted, srcpos will not be modified. Position/srcposition values will be constrained to nearby stretch markers. Returns index of stretch marker, or -1 if did not insert (or marker already existed at time).
---@param take MediaItem_Take
---@param idx integer
---@param pos number
---@param srcpos? number
---@return integer retval
function reaper.SetTakeStretchMarker(take, idx, pos, srcpos) end

---Set take stretch marker slope
---@param take MediaItem_Take
---@param idx integer
---@param slope number
---@return boolean retval
function reaper.SetTakeStretchMarkerSlope(take, idx, slope) end

---Set parameters of a tempo/time signature marker. Provide either timepos (with measurepos=-1, beatpos=-1), or measurepos and beatpos (with timepos=-1). If timesig_num and timesig_denom are zero, the previous time signature will be used. ptidx=-1 will insert a new tempo/time signature marker. 
---@param proj ReaProject
---@param ptidx integer
---@param timepos number
---@param measurepos integer
---@param beatpos number
---@param bpm number
---@param timesig_num integer
---@param timesig_denom integer
---@param lineartempo boolean
---@return boolean retval
function reaper.SetTempoTimeSigMarker(proj, ptidx, timepos, measurepos, beatpos, bpm, timesig_num, timesig_denom, lineartempo) end

---Temporarily updates the theme color to the color specified (or the theme default color if -1 is specified). 
---Returns -1 on failure, otherwise returns the color (or transformed-color). Note that the UI is not updated by this, the caller should call UpdateArrange etc as necessary. If the low bit of flags is set, any color transformations are bypassed. 
---To read a value see GetThemeColor * col_main_bg2 : Main window/transport background 
--- * col_main_text2 : Main window/transport text 
--- * col_main_textshadow : Main window text shadow (ignored if too close to text color) 
--- * col_main_3dhl : Main window 3D highlight 
--- * col_main_3dsh : Main window 3D shadow 
--- * col_main_resize2 : Main window pane resize mouseover 
--- * col_main_text : Themed Window text 
--- * col_main_bg : Themed Window background 
--- * col_main_editbk : Themed Window edit background 
--- * col_nodarkmodemiscwnd : Do not use window theming on macOS dark mode
--- * col_transport_editbk : Transport edit background 
--- * col_toolbar_text : Toolbar button text 
--- * col_toolbar_text_on : Toolbar button enabled text 
--- * col_toolbar_frame : Toolbar frame when floating or docked 
--- * toolbararmed_color : Toolbar button armed color 
--- * toolbararmed_drawmode : Toolbar button armed fill mode 
--- * io_text : I/O window text 
--- * io_3dhl : I/O window 3D highlight 
--- * io_3dsh : I/O window 3D shadow 
--- * genlist_bg : Window list background 
--- * genlist_fg : Window list text 
--- * genlist_grid : Window list grid lines 
--- * genlist_selbg : Window list selected row 
--- * genlist_selfg : Window list selected text 
--- * genlist_seliabg : Window list selected row (inactive) 
--- * genlist_seliafg : Window list selected text (inactive) 
--- * genlist_hilite : Window list highlighted text 
--- * genlist_hilite_sel : Window list highlighted selected text 
--- * col_buttonbg : Button background 
--- * col_tcp_text : Track panel text 
--- * col_tcp_textsel : Track panel (selected) text 
--- * col_seltrack : Selected track control panel background 
--- * col_seltrack2 : Unselected track control panel background (enabled with a checkbox above) 
--- * tcplocked_color : Locked track control panel overlay color 
--- * tcplocked_drawmode : Locked track control panel fill mode 
--- * col_tracklistbg : Empty track list area 
--- * col_mixerbg : Empty mixer list area 
--- * col_arrangebg : Empty arrange view area 
--- * arrange_vgrid : Empty arrange view area vertical grid shading 
--- * col_fadearm : Fader background when automation recording 
--- * col_fadearm2 : Fader background when automation playing 
--- * col_fadearm3 : Fader background when in inactive touch/latch 
--- * col_tl_fg : Timeline foreground 
--- * col_tl_fg2 : Timeline foreground (secondary markings) 
--- * col_tl_bg : Timeline background 
--- * col_tl_bgsel : Time selection color 
--- * timesel_drawmode : Time selection fill mode 
--- * col_tl_bgsel2 : Timeline background (in loop points) 
--- * col_trans_bg : Transport status background 
--- * col_trans_fg : Transport status text 
--- * playrate_edited : Project play rate control when not 1.0 
--- * col_mi_label : Media item label 
--- * col_mi_label_sel : Media item label (selected) 
--- * col_mi_label_float : Floating media item label 
--- * col_mi_label_float_sel : Floating media item label (selected) 
--- * col_mi_bg : Media item background (odd tracks) 
--- * col_mi_bg2 : Media item background (even tracks) 
--- * col_tr1_itembgsel : Media item background selected (odd tracks) 
--- * col_tr2_itembgsel : Media item background selected (even tracks) 
--- * itembg_drawmode : Media item background fill mode 
--- * col_tr1_peaks : Media item peaks (odd tracks) 
--- * col_tr2_peaks : Media item peaks (even tracks) 
--- * col_tr1_ps2 : Media item peaks when selected (odd tracks) 
--- * col_tr2_ps2 : Media item peaks when selected (even tracks) 
--- * col_peaksedge : Media item peaks edge highlight (odd tracks) 
--- * col_peaksedge2 : Media item peaks edge highlight (even tracks) 
--- * col_peaksedgesel : Media item peaks edge highlight when selected (odd tracks) 
--- * col_peaksedgesel2 : Media item peaks edge highlight when selected (even tracks) 
--- * cc_chase_drawmode : Media item MIDI CC peaks fill mode 
--- * col_peaksfade : Media item peaks when active in crossfade editor (fade-out) 
--- * col_peaksfade2 : Media item peaks when active in crossfade editor (fade-in) 
--- * col_mi_fades : Media item fade/volume controls 
--- * fadezone_color : Media item fade quiet zone fill color 
--- * fadezone_drawmode : Media item fade quiet zone fill mode 
--- * fadearea_color : Media item fade full area fill color 
--- * fadearea_drawmode : Media item fade full area fill mode 
--- * col_mi_fade2 : Media item edges of controls 
--- * col_mi_fade2_drawmode : Media item edges of controls blend mode 
--- * item_grouphl : Media item edge when selected via grouping 
--- * col_offlinetext : Media item "offline" text 
--- * col_stretchmarker : Media item stretch marker line 
--- * col_stretchmarker_h0 : Media item stretch marker handle (1x) 
--- * col_stretchmarker_h1 : Media item stretch marker handle (>1x) 
--- * col_stretchmarker_h2 : Media item stretch marker handle (<1x) 
--- * col_stretchmarker_b : Media item stretch marker handle edge 
--- * col_stretchmarkerm : Media item stretch marker blend mode 
--- * col_stretchmarker_text : Media item stretch marker text 
--- * col_stretchmarker_tm : Media item transient guide handle 
--- * take_marker : Media item take marker 
--- * selitem_tag : Selected media item bar color 
--- * activetake_tag : Active media item take bar color 
--- * col_tr1_bg : Track background (odd tracks) 
--- * col_tr2_bg : Track background (even tracks) 
--- * selcol_tr1_bg : Selected track background (odd tracks) 
--- * selcol_tr2_bg : Selected track background (even tracks) 
--- * col_tr1_divline : Track divider line (odd tracks) 
--- * col_tr2_divline : Track divider line (even tracks) 
--- * col_envlane1_divline : Envelope lane divider line (odd tracks) 
--- * col_envlane2_divline : Envelope lane divider line (even tracks) 
--- * mute_overlay_col : Muted/unsoloed track/item overlay color 
--- * mute_overlay_mode : Muted/unsoloed track/item overlay mode
--- * inactive_take_overlay_col : Inactive take overlay color
--- * inactive_take_overlay_mode : Inactive take overlay mode
--- * locked_overlay_col : Locked track/item overlay color
--- * locked_overlay_mode : Locked track/item overlay mode
--- * marquee_fill : Marquee fill 
--- * marquee_drawmode : Marquee fill mode 
--- * marquee_outline : Marquee outline 
--- * marqueezoom_fill : Marquee zoom fill 
--- * marqueezoom_drawmode : Marquee zoom fill mode 
--- * marqueezoom_outline : Marquee zoom outline 
--- * areasel_fill : Razor edit area fill 
--- * areasel_drawmode : Razor edit area fill mode 
--- * areasel_outline : Razor edit area outline 
--- * areasel_outlinemode : Razor edit area outline mode 
--- * col_cursor : Edit cursor 
--- * col_cursor2 : Edit cursor (alternate) 
--- * playcursor_color : Play cursor 
--- * playcursor_drawmode : Play cursor fill mode 
--- * col_gridlines2 : Grid lines (start of measure) 
--- * col_gridlines2dm : Grid lines (start of measure) - draw mode 
--- * col_gridlines3 : Grid lines (start of beats) 
--- * col_gridlines3dm : Grid lines (start of beats) - draw mode 
--- * col_gridlines : Grid lines (in between beats) 
--- * col_gridlines1dm : Grid lines (in between beats) - draw mode 
--- * guideline_color : Editing guide line color 
--- * guideline_drawmode : Editing guide fill mode 
--- * region : Regions 
--- * region_lane_bg : Region lane background 
--- * region_lane_text : Region lane text 
--- * marker : Markers 
--- * marker_lane_bg : Marker lane background 
--- * marker_lane_text : Marker lane text 
--- * col_tsigmark : Time signature change marker 
--- * ts_lane_bg : Time signature lane background 
--- * ts_lane_text : Time signature lane text 
--- * timesig_sel_bg : Time signature marker selected background 
--- * col_routinghl1 : Routing matrix row highlight 
--- * col_routinghl2 : Routing matrix column highlight 
--- * col_routingact : Routing matrix input activity highlight
--- * col_vudoint : Theme has interlaced VU meters 
--- * col_vuclip : VU meter clip indicator 
--- * col_vutop : VU meter top 
--- * col_vumid : VU meter middle 
--- * col_vubot : VU meter bottom 
--- * col_vuintcol : VU meter interlace/edge color 
--- * col_vumidi : VU meter midi activity 
--- * col_vuind1 : VU (indicator) - no signal 
--- * col_vuind2 : VU (indicator) - low signal 
--- * col_vuind3 : VU (indicator) - med signal 
--- * col_vuind4 : VU (indicator) - hot signal 
--- * mcp_sends_normal : Sends text: normal 
--- * mcp_sends_muted : Sends text: muted 
--- * mcp_send_midihw : Sends text: MIDI hardware 
--- * mcp_sends_levels : Sends level 
--- * mcp_fx_normal : FX insert text: normal 
--- * mcp_fx_bypassed : FX insert text: bypassed 
--- * mcp_fx_offlined : FX insert text: offline 
--- * mcp_fxparm_normal : FX parameter text: normal 
--- * mcp_fxparm_bypassed : FX parameter text: bypassed 
--- * mcp_fxparm_offlined : FX parameter text: offline 
--- * tcp_list_scrollbar : List scrollbar (track panel) 
--- * tcp_list_scrollbar_mode : List scrollbar (track panel) - draw mode 
--- * tcp_list_scrollbar_mouseover : List scrollbar mouseover (track panel) 
--- * tcp_list_scrollbar_mouseover_mode : List scrollbar mouseover (track panel) - draw mode 
--- * mcp_list_scrollbar : List scrollbar (mixer panel) 
--- * mcp_list_scrollbar_mode : List scrollbar (mixer panel) - draw mode 
--- * mcp_list_scrollbar_mouseover : List scrollbar mouseover (mixer panel) 
--- * mcp_list_scrollbar_mouseover_mode : List scrollbar mouseover (mixer panel) - draw mode 
--- * midi_rulerbg : MIDI editor ruler background 
--- * midi_rulerfg : MIDI editor ruler text 
--- * midi_grid2 : MIDI editor grid line (start of measure) 
--- * midi_griddm2 : MIDI editor grid line (start of measure) - draw mode 
--- * midi_grid3 : MIDI editor grid line (start of beats) 
--- * midi_griddm3 : MIDI editor grid line (start of beats) - draw mode 
--- * midi_grid1 : MIDI editor grid line (between beats) 
--- * midi_griddm1 : MIDI editor grid line (between beats) - draw mode 
--- * midi_trackbg1 : MIDI editor background color (naturals) 
--- * midi_trackbg2 : MIDI editor background color (sharps/flats) 
--- * midi_trackbg_outer1 : MIDI editor background color, out of bounds (naturals) 
--- * midi_trackbg_outer2 : MIDI editor background color, out of bounds (sharps/flats) 
--- * midi_selpitch1 : MIDI editor background color, selected pitch (naturals) 
--- * midi_selpitch2 : MIDI editor background color, selected pitch (sharps/flats) 
--- * midi_selbg : MIDI editor time selection color 
--- * midi_selbg_drawmode : MIDI editor time selection fill mode 
--- * midi_gridhc : MIDI editor CC horizontal center line 
--- * midi_gridhcdm : MIDI editor CC horizontal center line - draw mode 
--- * midi_gridh : MIDI editor CC horizontal line 
--- * midi_gridhdm : MIDI editor CC horizontal line - draw mode 
--- * midi_ccbut : MIDI editor CC lane add/remove buttons 
--- * midi_ccbut_text : MIDI editor CC lane button text 
--- * midi_ccbut_arrow : MIDI editor CC lane button arrow 
--- * midioct : MIDI editor octave line color 
--- * midi_inline_trackbg1 : MIDI inline background color (naturals) 
--- * midi_inline_trackbg2 : MIDI inline background color (sharps/flats) 
--- * midioct_inline : MIDI inline octave line color 
--- * midi_endpt : MIDI editor end marker 
--- * midi_notebg : MIDI editor note, unselected (midi_note_colormap overrides) 
--- * midi_notefg : MIDI editor note, selected (midi_note_colormap overrides) 
--- * midi_notemute : MIDI editor note, muted, unselected (midi_note_colormap overrides) 
--- * midi_notemute_sel : MIDI editor note, muted, selected (midi_note_colormap overrides) 
--- * midi_itemctl : MIDI editor note controls 
--- * midi_ofsn : MIDI editor note (offscreen) 
--- * midi_ofsnsel : MIDI editor note (offscreen, selected) 
--- * midi_editcurs : MIDI editor cursor 
--- * midi_pkey1 : MIDI piano key color (naturals background, sharps/flats text) 
--- * midi_pkey2 : MIDI piano key color (sharps/flats background, naturals text) 
--- * midi_pkey3 : MIDI piano key color (selected) 
--- * midi_noteon_flash : MIDI piano key note-on flash 
--- * midi_leftbg : MIDI piano pane background 
--- * midifont_col_light_unsel : MIDI editor note text and control color, unselected (light) 
--- * midifont_col_dark_unsel : MIDI editor note text and control color, unselected (dark) 
--- * midifont_mode_unsel : MIDI editor note text and control mode, unselected 
--- * midifont_col_light : MIDI editor note text and control color (light) 
--- * midifont_col_dark : MIDI editor note text and control color (dark) 
--- * midifont_mode : MIDI editor note text and control mode 
--- * score_bg : MIDI notation editor background 
--- * score_fg : MIDI notation editor staff/notation/text 
--- * score_sel : MIDI notation editor selected staff/notation/text 
--- * score_timesel : MIDI notation editor time selection 
--- * score_loop : MIDI notation editor loop points, selected pitch 
--- * midieditorlist_bg : MIDI list editor background 
--- * midieditorlist_fg : MIDI list editor text 
--- * midieditorlist_grid : MIDI list editor grid lines 
--- * midieditorlist_selbg : MIDI list editor selected row 
--- * midieditorlist_selfg : MIDI list editor selected text 
--- * midieditorlist_seliabg : MIDI list editor selected row (inactive) 
--- * midieditorlist_seliafg : MIDI list editor selected text (inactive) 
--- * midieditorlist_bg2 : MIDI list editor background (secondary) 
--- * midieditorlist_fg2 : MIDI list editor text (secondary) 
--- * midieditorlist_selbg2 : MIDI list editor selected row (secondary) 
--- * midieditorlist_selfg2 : MIDI list editor selected text (secondary) 
--- * col_explorer_sel : Media explorer selection 
--- * col_explorer_seldm : Media explorer selection mode 
--- * col_explorer_seledge : Media explorer selection edge 
--- * explorer_grid : Media explorer grid, markers
--- * explorer_pitchtext : Media explorer pitch detection text
--- * docker_shadow : Tab control shadow 
--- * docker_selface : Tab control selected tab 
--- * docker_unselface : Tab control unselected tab 
--- * docker_text : Tab control text 
--- * docker_text_sel : Tab control text selected tab 
--- * docker_bg : Tab control background 
--- * windowtab_bg : Tab control background in windows 
--- * auto_item_unsel : Envelope: Unselected automation item 
--- * col_env1 : Envelope: Volume (pre-FX) 
--- * col_env2 : Envelope: Volume 
--- * env_trim_vol : Envelope: Trim Volume 
--- * col_env3 : Envelope: Pan (pre-FX) 
--- * col_env4 : Envelope: Pan 
--- * env_track_mute : Envelope: Mute 
--- * col_env5 : Envelope: Master playrate 
--- * col_env6 : Envelope: Master tempo 
--- * col_env7 : Envelope: Width/Send volume 
--- * col_env8 : Envelope: Send pan 
--- * col_env9 : Envelope: Send volume 2 
--- * col_env10 : Envelope: Send pan 2 
--- * env_sends_mute : Envelope: Send mute 
--- * col_env11 : Envelope: Audio hardware output volume 
--- * col_env12 : Envelope: Audio hardware output pan 
--- * col_env13 : Envelope: FX parameter 1 
--- * col_env14 : Envelope: FX parameter 2 
--- * col_env15 : Envelope: FX parameter 3 
--- * col_env16 : Envelope: FX parameter 4 
--- * env_item_vol : Envelope: Item take volume 
--- * env_item_pan : Envelope: Item take pan 
--- * env_item_mute : Envelope: Item take mute 
--- * env_item_pitch : Envelope: Item take pitch 
--- * wiring_grid2 : Wiring: Background 
--- * wiring_grid : Wiring: Background grid lines 
--- * wiring_border : Wiring: Box border 
--- * wiring_tbg : Wiring: Box background 
--- * wiring_ticon : Wiring: Box foreground 
--- * wiring_recbg : Wiring: Record section background 
--- * wiring_recitem : Wiring: Record section foreground 
--- * wiring_activity : Wiring: Activity lights
--- * wiring_media : Wiring: Media 
--- * wiring_recv : Wiring: Receives 
--- * wiring_send : Wiring: Sends 
--- * wiring_fader : Wiring: Fader 
--- * wiring_parent : Wiring: Master/Parent 
--- * wiring_parentwire_border : Wiring: Master/Parent wire border 
--- * wiring_parentwire_master : Wiring: Master/Parent to master wire 
--- * wiring_parentwire_folder : Wiring: Master/Parent to parent folder wire 
--- * wiring_pin_normal : Wiring: Pins normal 
--- * wiring_pin_connected : Wiring: Pins connected 
--- * wiring_pin_disconnected : Wiring: Pins disconnected 
--- * wiring_horz_col : Wiring: Horizontal pin connections 
--- * wiring_sendwire : Wiring: Send hanging wire 
--- * wiring_hwoutwire : Wiring: Hardware output wire 
--- * wiring_recinputwire : Wiring: Record input wire 
--- * wiring_hwout : Wiring: System hardware outputs 
--- * wiring_recinput : Wiring: System record inputs 
--- * autogroup : Automatic track group
--- * group_0 : Group #1 
--- * group_1 : Group #2 
--- * group_2 : Group #3 
--- * group_3 : Group #4 
--- * group_4 : Group #5 
--- * group_5 : Group #6 
--- * group_6 : Group #7 
--- * group_7 : Group #8 
--- * group_8 : Group #9 
--- * group_9 : Group #10 
--- * group_10 : Group #11 
--- * group_11 : Group #12 
--- * group_12 : Group #13 
--- * group_13 : Group #14 
--- * group_14 : Group #15 
--- * group_15 : Group #16 
--- * group_16 : Group #17 
--- * group_17 : Group #18 
--- * group_18 : Group #19 
--- * group_19 : Group #20 
--- * group_20 : Group #21 
--- * group_21 : Group #22 
--- * group_22 : Group #23 
--- * group_23 : Group #24 
--- * group_24 : Group #25 
--- * group_25 : Group #26 
--- * group_26 : Group #27 
--- * group_27 : Group #28 
--- * group_28 : Group #29 
--- * group_29 : Group #30 
--- * group_30 : Group #31 
--- * group_31 : Group #32 
--- * group_32 : Group #33 
--- * group_33 : Group #34 
--- * group_34 : Group #35 
--- * group_35 : Group #36 
--- * group_36 : Group #37 
--- * group_37 : Group #38 
--- * group_38 : Group #39 
--- * group_39 : Group #40 
--- * group_40 : Group #41 
--- * group_41 : Group #42 
--- * group_42 : Group #43 
--- * group_43 : Group #44 
--- * group_44 : Group #45 
--- * group_45 : Group #46 
--- * group_46 : Group #47 
--- * group_47 : Group #48 
--- * group_48 : Group #49 
--- * group_49 : Group #50 
--- * group_50 : Group #51 
--- * group_51 : Group #52 
--- * group_52 : Group #53 
--- * group_53 : Group #54 
--- * group_54 : Group #55 
--- * group_55 : Group #56 
--- * group_56 : Group #57 
--- * group_57 : Group #58 
--- * group_58 : Group #59 
--- * group_59 : Group #60 
--- * group_60 : Group #61 
--- * group_61 : Group #62 
--- * group_62 : Group #63 
--- * group_63 : Group #64 
---@param ini_key string
---@param color integer
---@param flags integer
---@return integer retval
function reaper.SetThemeColor(ini_key, color, flags) end

---Updates the toggle state of an action, returns true if succeeded. Only ReaScripts can have their toggle states changed programmatically.
---@param section_id integer
---@param command_id integer
---@param state integer
---@return boolean retval
function reaper.SetToggleCommandState(section_id, command_id, state) end

---Set automation-mode for a specific MediaTrack.
---@param tr MediaTrack
---@param mode integer
function reaper.SetTrackAutomationMode(tr, mode) end

---Set the custom track color, color is OS dependent (i.e. ColorToNative(r,g,b).You cannot set default color with this function, use SetMediaTrackInfo_Value instead.
---@param track MediaTrack
---@param color integer
function reaper.SetTrackColor(track, color) end

---Set all MIDI lyrics on the track. Lyrics will be stuffed into any MIDI items found in range. Flag is unused at present. str is passed in as beat position, tab, text, tab example with flag=2: "1.1.2\tLyric for measure 1 beat 2\t2.1.1\tLyric for measure 2 beat 1 "
---@param track MediaTrack
---@param flag integer
---@param str string
---@return boolean retval
function reaper.SetTrackMIDILyrics(track, flag, str) end

---channel > 0 assigns these note names to all channels.
---@param track integer
---@param pitch integer
---@param chan integer
---@param name string
---@return boolean retval
function reaper.SetTrackMIDINoteName(track, pitch, chan, name) end

---channel > 0 assigns note name to all channels. pitch 128 assigns name for CC0, pitch 129 for CC1, etc.
---@param proj ReaProject
---@param track MediaTrack
---@param pitch integer
---@param chan integer
---@param name string
---@return boolean retval
function reaper.SetTrackMIDINoteNameEx(proj, track, pitch, chan, name) end

---Set a MediaTrack selected/deselected. Will retain already existing selection, so you can set multiple tracks selected that way.Will not affect Last-Touched-Track.
---@param track MediaTrack
---@param selected boolean
function reaper.SetTrackSelected(track, selected) end

---Set send/receive/hardware output numerical-value attributes, return true on success.
---category is <0 for receives, 0=sends, >0 for hardware outputs
---parameter names:   B_MUTE : bool *
---   B_PHASE : bool * : true to flip phase
---   B_MONO : bool *
---   D_VOL : double * : 1.0 = +0dB etc
---   D_PAN : double * : -1..+1
---   D_PANLAW : double * : 1.0=+0.0db, 0.5=-6dB, -1.0 = projdef etc
---   I_SENDMODE : int * : 0=post-fader, 1=pre-fx, 2=post-fx (deprecated), 3=post-fx
---   I_AUTOMODE : int * : automation mode (-1=use track automode, 0=trim/off, 1=read, 2=touch, 3=write, 4=latch)
---   I_SRCCHAN : int * : -1 for no audio send. Low 10 bits specify channel offset, and higher bits specify channel count. (srcchan>>10) == 0 for stereo, 1 for mono, 2 for 4 channel, 3 for 6 channel, etc.
---   I_DSTCHAN : int * : low 10 bits are destination index, &1024 set to mix to mono.
---   I_MIDIFLAGS : int * : low 5 bits=source channel 0=all, 1-16, next 5 bits=dest channel, 0=orig, 1-16=chan For ReaRoute-users: the outputs are hardware outputs, but with 512 added to the destination channel index (512 is the first rearoute channel, 513 the second, etc).Note: convert a dB_volume-value to the value expected by D_VOL in Lua, using: math.exp(db_value/8.68588963806)
---@param tr MediaTrack
---@param category integer
---@param sendidx integer
---@param parmname string
---@param newvalue number
---@return boolean retval
function reaper.SetTrackSendInfo_Value(tr, category, sendidx, parmname, newvalue) end

---send_idx<0 for receives, >=0 for hw ouputs, >=nb_of_hw_ouputs for sends. isend=1 for end of edit, -1 for an instant edit (such as reset), 0 for normal tweak.
---@param track MediaTrack
---@param send_idx integer
---@param pan number
---@param isend integer
---@return boolean retval
function reaper.SetTrackSendUIPan(track, send_idx, pan, isend) end

---send_idx<0 for receives, >=0 for hw ouputs, >=nb_of_hw_ouputs for sends. isend=1 for end of edit, -1 for an instant edit (such as reset), 0 for normal tweak.Note: convert a dB_volume-value to the value expected by parameter vol in Lua, using: math.exp(db_value/8.68588963806)
---@param track MediaTrack
---@param send_idx integer
---@param vol number
---@param isend integer
---@return boolean retval
function reaper.SetTrackSendUIVol(track, send_idx, vol, isend) end

---Sets the RPPXML state of a track, returns true if successful. Undo flag is a performance/caching hint.
---@param track MediaTrack
---@param str string
---@param isundo boolean
---@return boolean retval
function reaper.SetTrackStateChunk(track, str, isundo) end

---monitor: 0=no monitoring, 1=monitoring, 2=auto-monitoring. returns new value or -1 if error. igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
---@param track MediaTrack
---@param monitor integer
---@param igngroupflags integer
---@return integer retval
function reaper.SetTrackUIInputMonitor(track, monitor, igngroupflags) end

---mute: <0 toggles, >0 sets mute, 0=unsets mute. returns new value or -1 if error. igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
---@param track MediaTrack
---@param mute integer
---@param igngroupflags integer
---@return integer retval
function reaper.SetTrackUIMute(track, mute, igngroupflags) end

---sets pan of a certain trackigngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
---@param track MediaTrack
---@param pan number
---@param relative boolean
---@param done boolean
---@param igngroupflags integer
---@return number retval
function reaper.SetTrackUIPan(track, pan, relative, done, igngroupflags) end

---polarity (AKA phase): <0 toggles, 0=normal, >0=inverted. returns new value or -1 if error. igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
---@param track MediaTrack
---@param polarity integer
---@param igngroupflags integer
---@return integer retval
function reaper.SetTrackUIPolarity(track, polarity, igngroupflags) end

---recarm: <0 toggles, >0 sets recarm, 0=unsets recarm.returns new value or -1 if error. igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
---@param track MediaTrack
---@param recarm integer
---@param igngroupflags integer
---@return integer retval
function reaper.SetTrackUIRecArm(track, recarm, igngroupflags) end

---solo: <0 toggles, 1 sets solo (default mode), 0=unsets solo, 2 sets solo (non-SIP), 4 sets solo (SIP).returns new value or -1 if error. igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
---@param track MediaTrack
---@param solo integer
---@param igngroupflags integer
---@return integer retval
function reaper.SetTrackUISolo(track, solo, igngroupflags) end

---sets the volume of a trackigngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
---@param track MediaTrack
---@param volume number
---@param relative boolean
---@param done boolean
---@param igngroupflags integer
---@return number retval
function reaper.SetTrackUIVolume(track, volume, relative, done, igngroupflags) end

---sets the width of a track returns new value or -1 if error. igngroupflags: &1 to prevent track grouping, &2 to prevent selection ganging
---@param track MediaTrack
---@param width number
---@param relative boolean
---@param done boolean
---@param igngroupflags integer
---@return number retval
function reaper.SetTrackUIWidth(track, width, relative, done, igngroupflags) end

---shows a Reaper-context menu.
---You can decide, which menu to show and to which track/item/envelope/envelope-point/automation-item you want this context-menu to be applied to.
---e.g. you can decide, whether settings in the context-menu "track_panel" shall be applied to track 1, track 2, etcYou can also apply this to the selected track/mediaitem/envelope.
---The parameters name and ctx influence each other, means: name="item" and ctx=reaper.GetMediaItem(0,1) apply the mediaitem-contextmenu to the Mediaitem-object, given to parameter ctx.
---The choice of the parameter name also influences, whether ctxOptional and ctx2Optional can be set or not and what they mean.Blocks further execution of a script, until the context-menu is closed.
---@param name string
---@param x integer
---@param y integer
---@param hwndParent? HWND
---@param ctx identifier
---@param ctx2 integer
---@param ctx3 integer
function reaper.ShowPopupMenu(name, x, y, hwndParent, ctx, ctx2, ctx3) end

---shows the action-list
---@param section KbdSectionInfo
---@param callerWnd? HWND
function reaper.ShowActionList(section, callerWnd) end

---Show a message to the user (also useful for debugging). Send "\n" for newline, "" to clear the console.
---@param msg string
function reaper.ShowConsoleMsg(msg) end

---Shows Messagebox with user-clickable buttons.
---@param msg string
---@param title string
---@param type integer
---@return integer retval
function reaper.ShowMessageBox(msg, title, type) end

---Convert slider-value to it's dB-value-equivalent.
---@param y number
---@return number db_value
function reaper.SLIDER2DB(y) end

---@param project ReaProject
---@param time_pos number
---@return number retval
function reaper.SnapToGrid(project, time_pos) end

---Set solo-state for all tracks.
---@param solo integer
function reaper.SoloAllTracks(solo) end

---gets the splash window, in case you want to display a message over it. Returns NULL when the splash window is not displayed.
---@return HWND hwnd
function reaper.Splash_GetWnd() end

---The original item becomes the left-hand split, the function returns the right-hand split (or NULL if the split failed)
---@param item MediaItem
---@param position number
---@return MediaItem item
function reaper.SplitMediaItem(item, position) end

---@param str string
---@param gGUID string
---@return string gGUID
function reaper.stringToGuid(str, gGUID) end

---Stuffs a 3 byte MIDI message into either the Virtual MIDI Keyboard queue, or the MIDI-as-control input queue, or sends to a MIDI hardware output. mode=0 for VKB, 1 for control (actions map etc), 2 for VKB-on-current-channel; 16 for external MIDI device 0, 17 for external MIDI device 1, etc; see [GetNumMIDIOutputs](#GetNumMIDIOutputs), [GetMIDIOutputName](#GetMIDIOutputName).if mode is set to 1, you can send messages as control-message for Parameter Learn/Modulation and as shortcut for scripts.
---The parameter msg3 can be retrieved with the returnvalue val of the function reaper.get\_action\_context, so sending values to a script is possible that way.For more detailed information about the possible midi-messages you can send via StuffMIDIMessage, see: [StuffMIDIMessage-docs](misc_docs/API_How_StuffMidiMessage_works.txt)
---@param mode integer
---@param msg1 integer
---@param msg2 integer
---@param msg3 integer
function reaper.StuffMIDIMessage(mode, msg1, msg2, msg3) end

---Adds or queries the position of a named FX in a take. See [TrackFX\_AddByName()](#TrackFX_AddByName) for information on fxname and instantiate. 
---@param take MediaItem_Take
---@param fxname string
---@param instantiate integer
---@return integer retval
function reaper.TakeFX_AddByName(take, fxname, instantiate) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return boolean retval
function reaper.TakeFX_EndParamEdit(take, fx, param) end

---Note: only works with FX that support Cockos VST extensions.
---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@param val number
---@return boolean retval, string buf
function reaper.TakeFX_FormatParamValue(take, fx, param, val) end

---Note: only works with FX that support Cockos VST extensions.
---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@param value number
---@param buf string
---@return boolean retval, string buf
function reaper.TakeFX_FormatParamValueNormalized(take, fx, param, value, buf) end

---returns index of effect visible in chain, or -1 for chain hidden, or -2 for chain visible but no effect selected
---@param take MediaItem_Take
---@return integer retval
function reaper.TakeFX_GetChainVisible(take) end

---@param take MediaItem_Take
---@return integer retval
function reaper.TakeFX_GetCount(take) end

---See [TakeFX\_SetEnabled](#TakeFX_SetEnabled)
---@param take MediaItem_Take
---@param fx integer
---@return boolean retval
function reaper.TakeFX_GetEnabled(take, fx) end

---Returns the FX parameter envelope. If the envelope does not exist and create=true, the envelope will be created.
---@param take MediaItem_Take
---@param fxindex integer
---@param parameterindex integer
---@param create boolean
---@return TrackEnvelope env
function reaper.TakeFX_GetEnvelope(take, fxindex, parameterindex, create) end

---returns HWND of floating window for effect index, if any
---@param take MediaItem_Take
---@param index integer
---@return HWND hwnd
function reaper.TakeFX_GetFloatingWindow(take, index) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@param buf string
---@return boolean retval, string buf
function reaper.TakeFX_GetFormattedParamValue(take, fx, param, buf) end

---@param take MediaItem_Take
---@param fx integer
---@return string GUID
function reaper.TakeFX_GetFXGUID(take, fx) end

---@param take MediaItem_Take
---@param fx integer
---@return boolean retval, string buf
function reaper.TakeFX_GetFXName(take, fx) end

---gets the number of input/output pins for FX if available, returns plug-in type or -1 on error0, "DX"
---1, "LV2"
---2, "JSFX"
---3, "VST"
---5, "AU"
---6, "Video Processor"
---7, "CLAP"
---8, "Container"
---@param take MediaItem_Take
---@param fx integer
---@return integer retval, integer inputPins, integer outputPins
function reaper.TakeFX_GetIOSize(take, fx) end

---gets plug-in specific named configuration value (returns true on success)Supported values for read:
---  pdc : PDC latency
---  in_pin_X : name of input pin X
---  out_pin_X : name of output pin X
---  fx_type : type string
---  fx_ident : type-specific identifier
---  fx_name : pre-aliased name
---  GainReduction_dB : [ReaComp + other supported compressors]
---  vst_chunk[_program] : base64-encoded VST-specific chunk.
---  clap_chunk : base64-encoded CLAP-specific chunk.
---  param.X.lfo.[active,dir,phase,speed,strength,temposync,free,shape] : parameter moduation LFO state
---  param.X.acs.[active,dir,strength,attack,release,dblo,dbhi,chan,stereo,x2,y2] : parameter modulation ACS state
---  param.X.plink.[active,scale,offset,effect,param,midi_bus,midi_chan,midi_msg,midi_msg2] : parameter link/MIDI link: set effect=-100 to support midi_*
---  param.X.mod.[active,baseline,visible] : parameter module global settings
---  param.X.learn.[midi1,midi2,osc] : first two bytes of MIDI message, or OSC string if set
---  param.X.learn.mode : absolution/relative mode flag (0: Absolute, 1: 127=-1,1=+1, 2: 63=-1, 65=+1, 3: 65=-1, 1=+1, 4: toggle if nonzero)
---  param.X.learn.flags : &1=selected track only, &2=soft takeover, &4=focused FX only, &8=LFO retrigger, &16=visible FX only
---  
---  BANDTYPEx, BANDENABLEDx : band configuration [ReaEQ]
---  THRESHOLD, CEILING, TRUEPEAK : [ReaLlmit]
---  NUMCHANNELS, NUMSPEAKERS, RESETCHANNELS : [ReaSurroundPan]
---  ITEMx : [ReaVerb] state configuration line, when writing should be followed by a write of DONE
---  FILE, FILEx, -FILEx, +FILEx, -FILE* : [RS5k] file list, -/+ prefixes are write-only, when writing any, should be followed by a write of DONE
---  MODE, RSMODE : [RS5k] general mode, resample mode
---  VIDEO_CODE : [video processor] code
---  
---  force_auto_bypass : 0 or 1 - force auto-bypass plug-in on silence
---  instance_oversample_shift : instance oversampling shift amount, 0=none, 1=~96k, 2=~192k, etc. When setting requires playback stop/start to take effect
---  chain_oversample_shift : chain oversampling shift amount, 0=none, 1=~96k, 2=~192k, etc. When setting requires playback stop/start to take effect
---  chain_pdc_mode : chain PDC mode (0=classic, 1=new-default, 2=ignore PDC, 3=hwcomp-master)
---@param take MediaItem_Take
---@param fx integer
---@param parmname string
---@return boolean retval, string buf
function reaper.TakeFX_GetNamedConfigParm(take, fx, parmname) end

---@param take MediaItem_Take
---@param fx integer
---@return integer retval
function reaper.TakeFX_GetNumParams(take, fx) end

---Returns true if this FX UI is open in the FX chain window or a floating window. See [TakeFX\_SetOpen](#TakeFX_SetOpen)
---@param take MediaItem_Take
---@param fx integer
---@return boolean retval
function reaper.TakeFX_GetOpen(take, fx) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return number retval, number minval, number maxval
function reaper.TakeFX_GetParam(take, fx, param) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return boolean retval, number step, number smallstep, number largestep, boolean istoggle
function reaper.TakeFX_GetParameterStepSizes(take, fx, param) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return number retval, number minval, number maxval, number midval
function reaper.TakeFX_GetParamEx(take, fx, param) end

---gets the parameter index from an identifying string (:wet, :bypass, or a string returned from GetParamIdent), or -1 if unknown.
---@param take MediaItem_Take
---@param fx integer
---@param ident_str string
---@return integer param
function reaper.TakeFX_GetParamFromIdent(take, fx, ident_str) end

---gets an identifying string for the parameter
---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return boolean retval, string buf
function reaper.TakeFX_GetParamIdent(take, fx, param) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return boolean retval, string buf
function reaper.TakeFX_GetParamName(take, fx, param) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@return number retval
function reaper.TakeFX_GetParamNormalized(take, fx, param) end

---gets the effective channel mapping bitmask for a particular pin. high32Out will be set to the high 32 bits
---@param take MediaItem_Take
---@param fx integer
---@param isoutput integer
---@param pin integer
---@return integer retval, integer high32
function reaper.TakeFX_GetPinMappings(take, fx, isoutput, pin) end

---Get the name of the preset currently showing in the REAPER dropdown, or the full path to a factory preset file for VST3 plug-ins (.vstpreset). Returns false if the current FX parameters do not exactly match the preset (in other words, if the user loaded the preset but moved the knobs afterward). See TakeFX_SetPreset
---@param take MediaItem_Take
---@param fx integer
---@return boolean retval, string presetname
function reaper.TakeFX_GetPreset(take, fx) end

---Returns current preset index, or -1 if error. numberOfPresetsOut will be set to total number of presets available. See [TakeFX\_SetPresetByIndex](#TakeFX_SetPresetByIndex)
---@param take MediaItem_Take
---@param fx integer
---@return integer retval, integer numberOfPresets
function reaper.TakeFX_GetPresetIndex(take, fx) end

---@param take MediaItem_Take
---@param fx integer
---@return string fn
function reaper.TakeFX_GetUserPresetFilename(take, fx) end

---presetmove==1 activates the next preset, presetmove==-1 activates the previous preset, etc.
---@param take MediaItem_Take
---@param fx integer
---@param presetmove integer
---@return boolean retval
function reaper.TakeFX_NavigatePresets(take, fx, presetmove) end

---See [TakeFX\_GetEnabled](#TakeFX_GetEnabled)
---@param take MediaItem_Take
---@param fx integer
---@param enabled boolean
function reaper.TakeFX_SetEnabled(take, fx, enabled) end

---sets plug-in specific named configuration value (returns true on success).Support values for write:vst_chunk[_program] : base64-encoded VST-specific chunk.
---clap_chunk : base64-encoded CLAP-specific chunk.
---param.X.lfo.[active,dir,phase,speed,strength,temposync,free,shape] : parameter moduation LFO state
---param.X.acs.[active,dir,strength,attack,release,dblo,dbhi,chan,stereo,x2,y2] : parameter modulation ACS state
---param.X.plink.[active,scale,offset,effect,param,midi_bus,midi_chan,midi_msg,midi_msg2] : parameter link/MIDI link: set effect=-100 to support midi_*
---param.X.mod.[active,baseline,visible] : parameter module global settings
---param.X.learn.[midi1,midi2,osc] : first two bytes of MIDI message, or OSC string if set
---param.X.learn.mode : absolution/relative mode flag (0: Absolute, 1: 127=-1,1=+1, 2: 63=-1, 65=+1, 3: 65=-1, 1=+1, 4: toggle if nonzero)
---param.X.learn.flags : &1=selected track only, &2=soft takeover, &4=focused FX only, &8=LFO retrigger, &16=visible FX onlyBANDTYPEx, BANDENABLEDx : band configuration [ReaEQ]
---THRESHOLD, CEILING, TRUEPEAK : [ReaLlmit]
---NUMCHANNELS, NUMSPEAKERS, RESETCHANNELS : [ReaSurroundPan]
---ITEMx : [ReaVerb] state configuration line, when writing should be followed by a write of DONE
---FILE, FILEx, -FILEx, +FILEx, -FILE* : [RS5k] file list, -/+ prefixes are write-only, when writing any, should be followed by a write of DONE
---MODE, RSMODE : [RS5k] general mode, resample mode
---VIDEO_CODE : [video processor] codeforce_auto_bypass : 0 or 1 - force auto-bypass plug-in on silence
---instance_oversample_shift : instance oversampling shift amount, 0=none, 1=~96k, 2=~192k, etc. When setting requires playback stop/start to take effect
---chain_oversample_shift : chain oversampling shift amount, 0=none, 1=~96k, 2=~192k, etc. When setting requires playback stop/start to take effect
---chain_pdc_mode : chain PDC mode (0=classic, 1=new-default, 2=ignore PDC, 3=hwcomp-master)
---@param take MediaItem_Take
---@param fx integer
---@param parmname string
---@param value string
---@return boolean retval
function reaper.TakeFX_SetNamedConfigParm(take, fx, parmname, value) end

---Open this FX UI. See [TakeFX\_GetOpen](#TakeFX_GetOpen)
---@param take MediaItem_Take
---@param fx integer
---@param open boolean
function reaper.TakeFX_SetOpen(take, fx, open) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@param val number
---@return boolean retval
function reaper.TakeFX_SetParam(take, fx, param, val) end

---@param take MediaItem_Take
---@param fx integer
---@param param integer
---@param value number
---@return boolean retval
function reaper.TakeFX_SetParamNormalized(take, fx, param, value) end

---sets the channel mapping bitmask for a particular pin. returns false if unsupported (not all types of plug-ins support this capability)
---@param tk MediaItem_Take
---@param fx integer
---@param is integer
---@param pin integer
---@param low32bits integer
---@param hi32bits integer
---@return boolean retval
function reaper.TakeFX_SetPinMappings(tk, fx, is, pin, low32bits, hi32bits) end

---Activate a preset with the name shown in the REAPER dropdown. Full paths to .vstpreset files are also supported for VST3 plug-ins. See [TakeFX\_GetPreset](#TakeFX_GetPreset).presetname is case-sensitive.
---@param take MediaItem_Take
---@param fx integer
---@param presetname string
---@return boolean retval
function reaper.TakeFX_SetPreset(take, fx, presetname) end

---Sets the preset idx, or the factory preset (idx==-2), or the default user preset (idx==-1). Returns true on success. See [TakeFX\_GetPresetIndex](#TakeFX_GetPresetIndex).
---@param take MediaItem_Take
---@param fx integer
---@param idx integer
---@return boolean retval
function reaper.TakeFX_SetPresetByIndex(take, fx, idx) end

---showflag=0 for hidechain, =1 for show chain(index valid), =2 for hide floating window(index valid), =3 for show floating window (index valid)
---@param take MediaItem_Take
---@param index integer
---@param showFlag integer
function reaper.TakeFX_Show(take, index, showFlag) end

---Returns true if the active take contains MIDI.
---@param take MediaItem_Take
---@return boolean retval
function reaper.TakeIsMIDI(take) end

---Gets theme layout information.     section can be 'global' for global layout override, 'seclist' to enumerate a list of layout sections, otherwise a layout section such as 'mcp', 'tcp', 'trans', etc. 
---    idx can be 
---        -1 to query the current value, 
---        -2 to get the description of the section (if not global), 
---        -3 will return the current context DPI-scaling (256=normal, 512=retina, etc), or 0..x.  returns false if failed.
---@param section string
---@param idx integer
---@return boolean retval, string name
function reaper.ThemeLayout_GetLayout(section, idx) end

---returns theme layout parameter. return value is cfg-name, or nil/empty if out of range.
---@param wp integer
---@return string retval, string|nil desc, integer|nil value, integer|nil defValue, integer|nil minValue, integer|nil maxValue
function reaper.ThemeLayout_GetParameter(wp) end

---Refreshes all layouts
function reaper.ThemeLayout_RefreshAll() end

---Sets theme layout override for a particular section section can be 'global' or 'mcp' etc. If setting global layout, prefix a ! to the layout string to clear any per-layout overrides. Returns false if failed.
---@param section string
---@param layout string
---@return boolean retval
function reaper.ThemeLayout_SetLayout(section, layout) end

---sets theme layout parameter to value. persist=true in order to have change loaded on next theme load. note that the caller should update layouts via ??? to make changes visible.
---@param wp integer
---@param value integer
---@param persist boolean
---@return boolean retval
function reaper.ThemeLayout_SetParameter(wp, value, persist) end

---Gets a precise system timestamp in seconds.For EEL-programming, see [eel\_time\_precise](#eel_time_precise).
---@return number time_stamp
function reaper.time_precise() end

---convert a beat position (or optionally a beats+measures if measures is non-NULL) to time.
---@param proj ReaProject
---@param tpos number
---@param measures? integer
---@return number retval
function reaper.TimeMap2_beatsToTime(proj, tpos, measures) end

---get the effective BPM at the time (seconds) position (i.e. 2x in /8 signatures)
---@param proj ReaProject
---@param time number
---@return number retval
function reaper.TimeMap2_GetDividedBpmAtTime(proj, time) end

---when does the next time map (tempo or time sig) change occur
---@param proj ReaProject
---@param time number
---@return number retval
function reaper.TimeMap2_GetNextChangeTime(proj, time) end

---converts project QN position to time.
---@param proj ReaProject
---@param qn number
---@return number retval
function reaper.TimeMap2_QNToTime(proj, qn) end

---convert a time into beats.
---if measures is non-NULL, measures will be set to the measure count, return value will be beats since measure.
---if cml is non-NULL, will be set to current measure length in beats (i.e. time signature numerator)
---if fullbeats is non-NULL, and measures is non-NULL, fullbeats will get the full beat count (same value returned if measures is NULL).
---if cdenom is non-NULL, will be set to the current time signature denominator.
---@param proj ReaProject
---@param tpos number
---@return number retval, integer|nil measures, integer|nil cml, number|nil fullbeats, integer|nil cdenom
function reaper.TimeMap2_timeToBeats(proj, tpos) end

---converts project time position to QN position.
---@param proj ReaProject
---@param tpos number
---@return number retval
function reaper.TimeMap2_timeToQN(proj, tpos) end

---Gets project framerate, and optionally whether it is drop-frame timecode
---@param proj ReaProject
---@return number retval, boolean dropFrame
function reaper.TimeMap_curFrameRate(proj) end

---get the effective BPM at the time (seconds) position (i.e. 2x in /8 signatures)
---@param time number
---@return number retval
function reaper.TimeMap_GetDividedBpmAtTime(time) end

---Get the QN position and time signature information for the start of a measure. Return the time in seconds of the measure start.
---@param proj ReaProject
---@param measure integer
---@return number retval, number qn_start, number qn_end, integer timesig_num, integer timesig_denom, number tempo
function reaper.TimeMap_GetMeasureInfo(proj, measure) end

---Fills in a string representing the active metronome pattern. For example, in a 7/8 measure divided 3+4, the pattern might be "1221222". The length of the string is the time signature numerator, and the function returns the time signature denominator.
---@param proj ReaProject
---@param time number
---@param pattern string
---@return integer retval, string pattern
function reaper.TimeMap_GetMetronomePattern(proj, time, pattern) end

---get the effective time signature and tempo
---@param proj ReaProject
---@param time number
---@return integer timesig_num, integer timesig_denom, number tempo
function reaper.TimeMap_GetTimeSigAtTime(proj, time) end

---Find which measure the given QN position falls in.
---@param proj ReaProject
---@param qn number
---@return integer retval, number|nil qnMeasureStart, number|nil qnMeasureEnd
function reaper.TimeMap_QNToMeasures(proj, qn) end

---converts project QN position to time.
---@param qn number
---@return number retval
function reaper.TimeMap_QNToTime(qn) end

---Converts project quarter note count (QN) to time. QN is counted from the start of the project, regardless of any partial measures. See [TimeMap2\_QNToTime](#TimeMap2_QNToTime)
---@param proj ReaProject
---@param qn number
---@return number retval
function reaper.TimeMap_QNToTime_abs(proj, qn) end

---converts project QN position to time.
---@param tpos number
---@return number retval
function reaper.TimeMap_timeToQN(tpos) end

---Converts project time position to quarter note count (QN). QN is counted from the start of the project, regardless of any partial measures. See [TimeMap2\_timeToQN](#TimeMap2_timeToQN)
---@param proj ReaProject
---@param tpos number
---@return number retval
function reaper.TimeMap_timeToQN_abs(proj, tpos) end

---send_idx<0 for receives, >=0 for hw ouputs, >=nb_of_hw_ouputs for sends.
---@param track MediaTrack
---@param send_idx integer
---@return boolean retval
function reaper.ToggleTrackSendUIMute(track, send_idx) end

---Returns meter hold state, in dB*0.01 (0 = +0dB, -0.01 = -1dB, 0.02 = +2dB, etc). If clear is set, clears the meter hold. If channel==1024 or channel==1025, returns loudness values if this is the master track or this track's VU meters are set to display loudness.
---@param track MediaTrack
---@param channel integer
---@param clear boolean
---@return number retval
function reaper.Track_GetPeakHoldDB(track, channel, clear) end

---Returns peak meter value (1.0=+0dB, 0.0=-inf) for channel. If channel==1024 or channel==1025, returns loudness values if this is the master track or this track's VU meters are set to display loudness.
---@param track MediaTrack
---@param channel integer
---@return number retval
function reaper.Track_GetPeakInfo(track, channel) end

---Displays tooltip at location, or removes if empty string.Only one tooltip can be shown, means, a new tooltip removes the previous one.
---@param fmt string
---@param xpos integer
---@param ypos integer
---@param topmost boolean
function reaper.TrackCtl_SetToolTip(fmt, xpos, ypos, topmost) end

---Adds or queries the position of a named FX from the track FX chain (recFX=false) or record input FX/monitoring FX (recFX=true, monitoring FX are on master track). Specify a negative value for instantiate to always create a new effect, 
---0 to only query the first instance of an effect, or a positive value to add an instance if one is not found.Returns -1 on failure or the new position in chain on success.
---@param track MediaTrack
---@param fxname string
---@param recFX boolean
---@param instantiate integer
---@return integer retval
function reaper.TrackFX_AddByName(track, fxname, recFX, instantiate) end

---Copies (or moves) FX from src_track to dest_track. Can be used with src_track=dest_track to reorder, FX indices have 0x1000000 set to reference input FX. Note:
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---Add 0x1000000 to the fx-indices to address monitoringFX/rec-inputFX.
---@param src_track MediaTrack
---@param src_fx integer
---@param dest_track MediaTrack
---@param dest_fx integer
---@param is_move boolean
function reaper.TrackFX_CopyToTrack(src_track, src_fx, dest_track, dest_fx, is_move) end

---Copies (or moves) FX from src_track to dest_take. src_fx can have 0x1000000 set to reference input FX. Note:
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---Add 0x1000000 to the fx-indices to address monitoringFX/rec-inputFX.
---@param src_track MediaTrack
---@param src_fx integer
---@param dest_take MediaItem_Take
---@param dest_fx integer
---@param is_move boolean
function reaper.TrackFX_CopyToTake(src_track, src_fx, dest_take, dest_fx, is_move) end

---By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param param integer
---@return boolean retval
function reaper.TrackFX_EndParamEdit(track, fx, param) end

---returns a formatted version of the currently set parameter-value.Note: only works with FX that support Cockos VST extensions.By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.returns false in case of an error
---@param track MediaTrack
---@param fx integer
---@param param integer
---@param val number
---@return boolean retval, string buf
function reaper.TrackFX_FormatParamValue(track, fx, param, val) end

---returns a formatted version of the currently set parameter-value and normalizes it.Note: only works with FX that support Cockos VST extensions.By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.returns false in case of an error
---@param track MediaTrack
---@param fx integer
---@param param integer
---@param value number
---@param buf string
---@return boolean retval, string buf
function reaper.TrackFX_FormatParamValueNormalized(track, fx, param, value, buf) end

---Get the index of the first track FX insert that matches fxname. If the FX is not in the chain and instantiate is true, it will be inserted. See [TrackFX\_GetInstrument](#TrackFX_GetInstrument), [TrackFX\_GetEQ](#TrackFX_GetEQ). Deprecated in favor of TrackFX_AddByName.returns -1 in case of an error
---@param track MediaTrack
---@param fxname string
---@param instantiate boolean
---@return integer retval
function reaper.TrackFX_GetByName(track, fxname, instantiate) end

---returns index of effect visible in chain, or -1 for chain hidden, or -2 for chain visible but no effect selected
---@param track MediaTrack
---@return integer retval
function reaper.TrackFX_GetChainVisible(track) end

---returns the number of trackfx in the FXChain of track
---@param track MediaTrack
---@return integer retval
function reaper.TrackFX_GetCount(track) end

---returns, if a certain FX in track is enabledSee [TrackFX\_SetEnabled](#TrackFX_SetEnabled)By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.returns false in case of an error
---@param track MediaTrack
---@param fx integer
---@return boolean retval
function reaper.TrackFX_GetEnabled(track, fx) end

---Get the index of ReaEQ in the track FX chain. If ReaEQ is not in the chain and instantiate is true, it will be inserted. See [TrackFX\_GetInstrument](#TrackFX_GetInstrument), [TrackFX\_GetByName](#TrackFX_GetByName).returns -1 if no ReaEQ is available.
---@param track MediaTrack
---@param instantiate boolean
---@return integer retval
function reaper.TrackFX_GetEQ(track, instantiate) end

---Returns true if the EQ band is enabled.
---Returns false if the band is disabled, or if track/fxidx is not ReaEQ.
---Bandtype: -1=master gain, 0=hipass, 1=loshelf, 2=band, 3=notch, 4=hishelf, 5=lopass, 6=bandpass, 7=parallel bandpass.
---Bandidx:(ignored for master gain): 0=target first band matching bandtype, 1=target 2nd band matching bandtype, etc.By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.See [TrackFX\_GetEQ](#TrackFX_GetEQ), [TrackFX\_GetEQParam](#TrackFX_GetEQParam), [TrackFX\_SetEQParam](#TrackFX_SetEQParam), [TrackFX\_SetEQBandEnabled](#TrackFX_SetEQBandEnabled).
---@param track MediaTrack
---@param fx integer
---@param bandtype integer
---@param bandidx integer
---@return boolean retval
function reaper.TrackFX_GetEQBandEnabled(track, fx, bandtype, bandidx) end

---Returns false if track/fxidx is not ReaEQ.
---Bandtype: -1=master gain, 0=hipass, 1=loshelf, 2=band, 3=notch, 4=hishelf, 5=lopass, 6=bandpass, 7=parallel bandpass.
---Bandidx (ignored for master gain): 0=first band matching bandtype, 1=2nd band matching bandtype, etc.
---Paramtype (ignored for master gain): 0=freq, 1=gain, 2=Q.By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.See [TrackFX\_GetEQ](#TrackFX_GetEQ), [TrackFX\_SetEQParam](#TrackFX_SetEQParam), [TrackFX\_GetEQBandEnabled](#TrackFX_GetEQBandEnabled), [TrackFX\_SetEQBandEnabled](#TrackFX_SetEQBandEnabled).
---@param track MediaTrack
---@param fx integer
---@param paramidx integer
---@return boolean retval, integer bandtype, integer bandidx, integer paramtype, number normval
function reaper.TrackFX_GetEQParam(track, fx, paramidx) end

---returns HWND of floating window for effect index, if anyBy setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@return HWND hwnd
function reaper.TrackFX_GetFloatingWindow(track, fx) end

---By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param param integer
---@return boolean retval, string buf
function reaper.TrackFX_GetFormattedParamValue(track, fx, param) end

---By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@return string GUID
function reaper.TrackFX_GetFXGUID(track, fx) end

---By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@return boolean retval, string buf
function reaper.TrackFX_GetFXName(track, fx) end

---Get the index of the first track FX insert that is a virtual instrument, or -1 if none. See [TrackFX\_GetEQ](#TrackFX_GetEQ), [TrackFX\_GetByName](#TrackFX_GetByName).
---@param track MediaTrack
---@return integer retval
function reaper.TrackFX_GetInstrument(track) end

---gets the number of input/output pins for FX if available, returns plug-in type or -1 on errorBy setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.0, "DX"
---1, "LV2"
---2, "JSFX"
---3, "VST"
---5, "AU"
---6, "Video Processor"
---7, "CLAP"
---8, "Container"
---@param track MediaTrack
---@param fx integer
---@return integer retval, integer inputPins, integer outputPins
function reaper.TrackFX_GetIOSize(track, fx) end

---gets plug-in specific named configuration value (returns true on success). By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.            Supported values for read:
---  pdc : PDC latency
---  in_pin_X : name of input pin X
---  out_pin_X : name of output pin X
---  fx_type : type string
---  fx_ident : type-specific identifier
---  fx_name : pre-aliased name
---  GainReduction_dB : [ReaComp + other supported compressors]
---  
---  original_name : pre-renamed FX instance name
---  renamed_name : renamed FX instance name (empty string = not renamed)
---  
---  vst_chunk[_program] : base64-encoded VST-specific chunk.
---  clap_chunk : base64-encoded CLAP-specific chunk.
---  
---  param.X.lfo.[active,dir,phase,speed,strength,temposync,free,shape] : parameter moduation LFO state
---  param.X.acs.[active,dir,strength,attack,release,dblo,dbhi,chan,stereo] : parameter modulation ACS state
---  param.X.plink.[active,scale,offset,effect,param,midi_bus,midi_chan,midi_msg,midi_msg2] : parameter link/MIDI link: set effect=-100 to support midi_*
---  param.X.mod.[active,baseline,visible] : parameter module global settings
---  param.X.learn.[midi1,midi2,osc] : first two bytes of MIDI message, or OSC string if set
---  param.X.learn.mode : absolution/relative mode flag (0: Absolute, 1: 127=-1,1=+1, 2: 63=-1, 65=+1, 3: 65=-1, 1=+1, 4: toggle if nonzero)
---  param.X.learn.flags : &1=selected track only, &2=soft takeover, &4=focused FX only, &8=LFO retrigger, &16=visible FX only
---  BANDTYPEx, BANDENABLEDx : band configuration [ReaEQ]
---  THRESHOLD, CEILING, TRUEPEAK : [ReaLlmit]
---  NUMCHANNELS, NUMSPEAKERS, RESETCHANNELS : [ReaSurroundPan]
---  
---  ITEMx : [ReaVerb] state configuration line, when writing should be followed by a write of DONE
---  FILE, FILEx, -FILEx, +FILEx, -FILE* : [RS5k] file list, -/+ prefixes are write-only, when writing any, should be followed by a write of DONE
---  MODE, RSMODE : [RS5k] general mode, resample mode
---  VIDEO_CODE : [video processor] code
---  
---  force_auto_bypass : 0 or 1 - force auto-bypass plug-in on silence
---  instance_oversample_shift : instance oversampling shift amount, 0=none, 1=~96k, 2=~192k, etc. When setting requires playback stop/start to take effect
---  chain_oversample_shift : chain oversampling shift amount, 0=none, 1=~96k, 2=~192k, etc. When setting requires playback stop/start to take effect
---  chain_pdc_mode : chain PDC mode (0=classic, 1=new-default, 2=ignore PDC, 3=hwcomp-master)
---@param track MediaTrack
---@param fx integer
---@param parmname string
---@return boolean retval, string buf
function reaper.TrackFX_GetNamedConfigParm(track, fx, parmname) end

---By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@return integer retval
function reaper.TrackFX_GetNumParams(track, fx) end

---Returns true if this FX UI is open in the FX chain window or a floating window. See [TrackFX\_SetOpen](#TrackFX_SetOpen)By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@return boolean retval
function reaper.TrackFX_GetOpen(track, fx) end

---By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param param integer
---@return number retval, number minval, number maxval
function reaper.TrackFX_GetParam(track, fx, param) end

---By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param param integer
---@return boolean retval, number step, number smallstep, number largestep, boolean istoggle
function reaper.TrackFX_GetParameterStepSizes(track, fx, param) end

---By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param param integer
---@return number retval, number minval, number maxval, number midval
function reaper.TrackFX_GetParamEx(track, fx, param) end

---gets the parameter index from an identifying string (:wet, :bypass, :delta, or a string returned from GetParamIdent), or -1 if unknown.
---@param track MediaTrack
---@param fx integer
---@param ident_str string
---@return integer param
function reaper.TrackFX_GetParamFromIdent(track, fx, ident_str) end

---gets an identifying string for the parameter
---@param track MediaTrack
---@param fx integer
---@param param integer
---@return boolean retval, string buf
function reaper.TrackFX_GetParamIdent(track, fx, param) end

---By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param param integer
---@return boolean retval, string buf
function reaper.TrackFX_GetParamName(track, fx, param) end

---By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param param integer
---@return number retval
function reaper.TrackFX_GetParamNormalized(track, fx, param) end

---gets the effective channel mapping bitmask for a particular pin. high32Out will be set to the high 32 bitsBy setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param tr MediaTrack
---@param fx integer
---@param isoutput integer
---@param pin integer
---@return integer retval, integer high32
function reaper.TrackFX_GetPinMappings(tr, fx, isoutput, pin) end

---Get the name of the preset currently showing in the REAPER dropdown, or the full path to a factory preset file for VST3 plug-ins (.vstpreset). Returns false if the current FX parameters do not exactly match the preset (in other words, if the user loaded the preset but moved the knobs afterward). see TrackFX_SetPresetBy setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@return boolean retval, string presetname
function reaper.TrackFX_GetPreset(track, fx) end

---Returns current preset index, or -1 if error. numberOfPresetsOut will be set to total number of presets available. See [TrackFX\_SetPresetByIndex](#TrackFX_SetPresetByIndex)By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@return integer retval, integer numberOfPresets
function reaper.TrackFX_GetPresetIndex(track, fx) end

---returns index of effect visible in record input chain, or -1 for chain hidden, or -2 for chain visible but no effect selectedTo get the monitoring FX rather than record input FX, use Master-Track.Note:
---To access record input FX in other TrackFX-functions, use FX indices [0x1000000..0x1000000+n) for the individual fxs in the FXChain and pass over the track, whose rec-input-fxchain you want to access.
---Also pass over the track, whose rec-input-fx you want to access. Pass over MasterTrack to get the monitoring FX-chain.
---@param track MediaTrack
---@return integer retval
function reaper.TrackFX_GetRecChainVisible(track) end

---returns count of record input FX of a track. To get the monitoring FX rather than record input FX, use Master-Track.Note:
---To access record input FX in other TrackFX-functions, use FX indices [0x1000000..0x1000000+n) for the individual fxs in the FXChain and pass over the track, whose rec-input-fxchain you want to access.
---Also pass over the track, whose rec-input-fx you want to access. Pass over MasterTrack to get the monitoring FX-chain.
---
---@param track MediaTrack
---@return integer retval
function reaper.TrackFX_GetRecCount(track) end

---By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@return string fn
function reaper.TrackFX_GetUserPresetFilename(track, fx) end

---presetmove==1 activates the next preset, presetmove==-1 activates the previous preset, etc.By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param presetmove integer
---@return boolean retval
function reaper.TrackFX_NavigatePresets(track, fx, presetmove) end

---Set a TrackFX enabled/disabled.By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.See [TrackFX\_GetEnabled](#TrackFX_GetEnabled)
---@param track MediaTrack
---@param fx integer
---@param enabled boolean
function reaper.TrackFX_SetEnabled(track, fx, enabled) end

---Enable or disable a ReaEQ band.
---Returns false if track/fxidx is not ReaEQ.
---Bandtype: -1=master gain, 0=hipass, 1=loshelf, 2=band, 3=notch, 4=hishelf, 5=lopass, 6=bandpass, 7=parallel bandpass
---Bandidx: (ignored for master gain): 0=target first band matching bandtype, 1=target 2nd band matching bandtype, etc.
---See [TrackFX\_GetEQ](#TrackFX_GetEQ), [TrackFX\_GetEQParam](#TrackFX_GetEQParam), [TrackFX\_SetEQParam](#TrackFX_SetEQParam), [TrackFX\_GetEQBandEnabled](#TrackFX_GetEQBandEnabled).By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fxidx integer
---@param bandtype integer
---@param bandidx integer
---@param enable boolean
---@return boolean 
function reaper.TrackFX_SetEQBandEnabled(track, fxidx, bandtype, bandidx, enable) end

---Returns false if track/fxidx is not ReaEQ. Targets a band matching bandtype.
---Bandtype: -1=master gain, 0=hipass, 1=loshelf, 2=band, 3=notch, 4=hishelf, 5=lopass, 6=bandpass, 7=parallel bandpass.
---Bandidx (ignored for master gain): 0=target first band matching bandtype, 1=target 2nd band matching bandtype, etc.
---Paramtype (ignored for master gain): 0=freq, 1=gain, 2=Q.
---See [TrackFX\_GetEQ](#TrackFX_GetEQ), [TrackFX\_GetEQParam](#TrackFX_GetEQParam), [TrackFX\_GetEQBandEnabled](#TrackFX_GetEQBandEnabled), [TrackFX\_SetEQBandEnabled](#TrackFX_SetEQBandEnabled).By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param bandtype integer
---@param bandidx integer
---@param paramtype integer
---@param val number
---@param isnorm boolean
---@return boolean retval
function reaper.TrackFX_SetEQParam(track, fx, bandtype, bandidx, paramtype, val, isnorm) end

---sets plug-in specific named configuration value (returns true on success)By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.Support values for write:vst_chunk[_program] : base64-encoded VST-specific chunk.
---clap_chunk : base64-encoded CLAP-specific chunk.
---param.X.lfo.[active,dir,phase,speed,strength,temposync,free,shape] : parameter moduation LFO state
---param.X.acs.[active,dir,strength,attack,release,dblo,dbhi,chan,stereo] : parameter modulation ACS state
---param.X.plink.[active,scale,offset,effect,param,midi_bus,midi_chan,midi_msg,midi_msg2] : parameter link/MIDI link: set effect=-100 to support midi_*
---param.X.mod.[active,baseline,visible] : parameter module global settings
---param.X.learn.[midi1,midi2,osc] : first two bytes of MIDI message, or OSC string if set
---param.X.learn.mode : absolution/relative mode flag (0: Absolute, 1: 127=-1,1=+1, 2: 63=-1, 65=+1, 3: 65=-1, 1=+1, 4: toggle if nonzero)
---param.X.learn.flags : &1=selected track only, &2=soft takeover, &4=focused FX only, &8=LFO retrigger, &16=visible FX onlyBANDTYPEx, BANDENABLEDx : band configuration [ReaEQ]
---THRESHOLD, CEILING, TRUEPEAK : [ReaLlmit]
---NUMCHANNELS, NUMSPEAKERS, RESETCHANNELS : [ReaSurroundPan]
---ITEMx : [ReaVerb] state configuration line, when writing should be followed by a write of DONE
---FILE, FILEx, -FILEx, +FILEx, -FILE* : [RS5k] file list, -/+ prefixes are write-only, when writing any, should be followed by a write of DONE
---MODE, RSMODE : [RS5k] general mode, resample mode
---VIDEO_CODE : [video processor] codeforce_auto_bypass : 0 or 1 - force auto-bypass plug-in on silence
---instance_oversample_shift : instance oversampling shift amount, 0=none, 1=~96k, 2=~192k, etc. When setting requires playback stop/start to take effect
---chain_oversample_shift : chain oversampling shift amount, 0=none, 1=~96k, 2=~192k, etc. When setting requires playback stop/start to take effect
---chain_pdc_mode : chain PDC mode (0=classic, 1=new-default, 2=ignore PDC, 3=hwcomp-master)renamed_name : renamed FX instance name (empty string = not renamed)
---@param track MediaTrack
---@param fx integer
---@param parmname string
---@param value string
---@return boolean retval
function reaper.TrackFX_SetNamedConfigParm(track, fx, parmname, value) end

---See [TrackFX\_GetOffline](#TrackFX_GetOffline)By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param offline boolean
function reaper.TrackFX_SetOffline(track, fx, offline) end

---See [TakeFX\_GetOffline](#TakeFX_GetOffline)
---@param take MediaItem_Take
---@param fx integer
---@param offline boolean
function reaper.TakeFX_SetOffline(take, fx, offline) end

---See [TakeFX\_SetOffline](#TakeFX_SetOffline)
---@param take MediaItem_Take
---@param fx integer
---@return boolean retval
function reaper.TakeFX_GetOffline(take, fx) end

---Remove a FX from take chain (returns true on success)
---@param take MediaItem_Take
---@param fx integer
---@return boolean retval
function reaper.TakeFX_Delete(take, fx) end

---Copies (or moves) FX from src_take to dest_take. Can be used with src_take=dest_take to reorder. 
---@param src_take MediaItem_Take
---@param src_fx integer
---@param dest_take MediaItem_Take
---@param dest_fx integer
---@param is_move boolean
function reaper.TakeFX_CopyToTake(src_take, src_fx, dest_take, dest_fx, is_move) end

---Copies (or moves) FX from src_take to dest_track. Note:
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---Add 0x1000000 to the fx-indices to address monitoringFX/rec-inputFX.
---@param src_take MediaItem_Take
---@param src_fx integer
---@param dest_track MediaTrack
---@param dest_fx integer
---@param is_move boolean
function reaper.TakeFX_CopyToTrack(src_take, src_fx, dest_track, dest_fx, is_move) end

---See [TrackFX\_SetOffline](#TrackFX_SetOffline)By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@return boolean retval
function reaper.TrackFX_GetOffline(track, fx) end

---Remove a FX from track chain (returns true on success).By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@return boolean retval
function reaper.TrackFX_Delete(track, fx) end

---Open this FX UI. See [TrackFX\_GetOpen](#TrackFX_GetOpen)By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param open boolean
function reaper.TrackFX_SetOpen(track, fx, open) end

---By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param param integer
---@param val number
---@return boolean retval
function reaper.TrackFX_SetParam(track, fx, param, val) end

---By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param param integer
---@param value number
---@return boolean retval
function reaper.TrackFX_SetParamNormalized(track, fx, param, value) end

---sets the channel mapping bitmask for a particular pin. returns false if unsupported (not all types of plug-ins support this capability)By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param tr MediaTrack
---@param fx integer
---@param is integer
---@param pin integer
---@param low32bits integer
---@param hi32bits integer
---@return boolean retval
function reaper.TrackFX_SetPinMappings(tr, fx, is, pin, low32bits, hi32bits) end

---Activate a preset with the name shown in the REAPER dropdown. Full paths to .vstpreset files are also supported for VST3 plug-ins. See [TrackFX\_GetPreset](#TrackFX_GetPreset).By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.presetname is case-sensitive.
---@param track MediaTrack
---@param fx integer
---@param presetname string
---@return boolean retval
function reaper.TrackFX_SetPreset(track, fx, presetname) end

---Sets the preset idx, or the factory preset (idx==-2), or the default user preset (idx==-1). Returns true on success. See [TrackFX\_GetPresetIndex](#TrackFX_GetPresetIndex).By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param idx integer
---@return boolean retval
function reaper.TrackFX_SetPresetByIndex(track, fx, idx) end

---Shows a track-FX-window.By setting fx you can add 0x1000000 set to reference input FX. 
---To use global monitoring inputFX, use the master-track, any other track will access the track's rec-input-fx.
---@param track MediaTrack
---@param fx integer
---@param showFlag integer
function reaper.TrackFX_Show(track, fx, showFlag) end

---Updates the TCP and optionally the MCP. Helpful, when setting a new trackheight using I\_HEIGHTOVERRIDE in [SetMediaTrackInfo\_Value](#SetMediaTrackInfo_Value).This also updates the Region Render Matrix.
---@param isMinor boolean
function reaper.TrackList_AdjustWindows(isMinor) end

function reaper.TrackList_UpdateAllExternalSurfaces() end

---call to start a new block
function reaper.Undo_BeginBlock() end

---call to start a new undo block. Code after that and before Undo_EndBlock can be undone.
---@param proj ReaProject
function reaper.Undo_BeginBlock2(proj) end

---returns string of next action,if able,NULL if notbasically, if you undid an action, this will return the description of the action you undid.
---@param proj ReaProject
---@return string undo_string
function reaper.Undo_CanRedo2(proj) end

---returns string of last action,if able,NULL if notbasically returns the description of the next undoable action
---@param proj ReaProject
---@return string undo_text
function reaper.Undo_CanUndo2(proj) end

---redo an undone actionnonzero if success
---@param proj ReaProject
---@return integer retval
function reaper.Undo_DoRedo2(proj) end

---undo an undoable actionnonzero if success
---@param proj ReaProject
---@return integer retval
function reaper.Undo_DoUndo2(proj) end

---call to end the block,with extra flags if any,and a description
---@param descchange string
---@param extraflags integer
function reaper.Undo_EndBlock(descchange, extraflags) end

---call to end the block,with extra flags if any,and a description
---@param proj ReaProject
---@param descchange string
---@param extraflags integer
function reaper.Undo_EndBlock2(proj, descchange, extraflags) end

---limited state change to items
---@param descchange string
function reaper.Undo_OnStateChange(descchange) end

---limited state change to items
---@param proj ReaProject
---@param descchange string
function reaper.Undo_OnStateChange2(proj, descchange) end

---@param proj ReaProject
---@param name string
---@param item MediaItem
function reaper.Undo_OnStateChange_Item(proj, name, item) end

---trackparm=-1 by default,or if updating one fx chain,you can specify track index
---@param descchange string
---@param whichStates integer
---@param trackparm integer
function reaper.Undo_OnStateChangeEx(descchange, whichStates, trackparm) end

---trackparm=-1 by default,or if updating one fx chain,you can specify track index
---@param proj ReaProject
---@param descchange string
---@param whichStates integer
---@param trackparm integer
function reaper.Undo_OnStateChangeEx2(proj, descchange, whichStates, trackparm) end

---Redraw the arrange view
function reaper.UpdateArrange() end

---@param item MediaItem
function reaper.UpdateItemInProject(item) end

---Redraw the arrange view and ruler
function reaper.UpdateTimeline() end

---Return true if the pointer is a valid object of the right type in proj (proj is ignored if pointer is itself a project). 
---Supported types are: ReaProject*, MediaTrack*, MediaItem*, MediaItem_Take*, TrackEnvelope* and PCM_source*.see ValidatePtr2
---@param pointer identifier
---@param ctypename string
---@return boolean retval
function reaper.ValidatePtr(pointer, ctypename) end

---Return true if the pointer is a valid object of the right type in proj (proj is ignored if pointer is itself a project). Supported types are: ReaProject*, MediaTrack*, MediaItem*, MediaItem_Take*, TrackEnvelope* and PCM_source*.
---@param proj ReaProject
---@param pointer identifier
---@param ctypename string
---@return boolean retval
function reaper.ValidatePtr2(proj, pointer, ctypename) end

---Opens the prefs to a page, use pageByName if page is 0.
---@param page integer
---@param pageByName string
function reaper.ViewPrefs(page, pageByName) end

---Gets or modifies the group membership for a track. Returns group state prior to call (each bit represents one of the high 32 group numbers). if setmask has bits set, those bits in setvalue will be applied to group. Group can be one of:
---VOLUME_LEAD
---VOLUME_FOLLOW
---VOLUME_VCA_LEAD
---VOLUME_VCA_FOLLOW
---PAN_LEAD
---PAN_FOLLOW
---WIDTH_LEAD
---WIDTH_FOLLOW
---MUTE_LEAD
---MUTE_FOLLOW
---SOLO_LEAD
---SOLO_FOLLOW
---RECARM_LEAD
---RECARM_FOLLOW
---POLARITY_LEAD
---POLARITY_FOLLOW
---AUTOMODE_LEAD
---AUTOMODE_FOLLOW
---VOLUME_REVERSE
---PAN_REVERSE
---WIDTH_REVERSE
---NO_LEAD_WHEN_FOLLOW
---VOLUME_VCA_FOLLOW_ISPREFX
---MEDIA_EDIT_LEAD
---MEDIA_EDIT_FOLLOWNote: REAPER v6.11 and earlier used _MASTER and _SLAVE rather than _LEAD and _FOLLOW, which is deprecated but still supported (scripts that must support v6.11 and earlier can use the deprecated strings).
---@param tr MediaTrack
---@param groupname string
---@param setmask integer
---@param setvalue integer
---@return integer groupstate
function reaper.GetSetTrackGroupMembershipHigh(tr, groupname, setmask, setvalue) end

---Gets/sets a send attribute string:
---    P_EXT:xyz : char * : extension-specific persistent dataThis is a little like extstates for routings, with xyz being the key and stringNeedBig being the value.For ReaRoute-users: the outputs are hardware outputs, but with 512 added to the destination channel index (512 is the first rearoute channel, 513 the second, etc).
---@param tr MediaTrack
---@param category integer
---@param sendidx integer
---@param parmname string
---@param stringNeedBig string
---@param setNewValue boolean
---@return boolean retval, string stringNeedBig
function reaper.GetSetTrackSendInfo_String(tr, category, sendidx, parmname, stringNeedBig, setNewValue) end

---[BR] Create a BR_Envelope-object from a track-envelope pointer or take-envelope pointer. 
---To apply changes to a BR_Envelope-object, always call BR_EnvFree to release the object and commit changes if needed.
---A BR_Envelope is not a TrackEnvelope-object and therefore can't be used as TrackEnvelope-object!Delete a BR_Envelope with BR_EnvFree.For manipulation see BR_EnvCountPoints, BR_EnvDeletePoint, BR_EnvFind, BR_EnvFindNext, BR_EnvFindPrevious, BR_EnvGetParentTake, BR_EnvGetParentTrack, BR_EnvGetPoint, BR_EnvGetProperties, BR_EnvSetPoint, BR_EnvSetProperties, BR_EnvValueAtPos.
---@param envelope TrackEnvelope
---@param takeEnvelopesUseProjectTime boolean
---@return BR_Envelope env
function reaper.BR_EnvAlloc(envelope, takeEnvelopesUseProjectTime) end

---[BR] Count envelope points in the envelope object allocated with BR_EnvAlloc.
---@param envelope BR_Envelope
---@return integer retval
function reaper.BR_EnvCountPoints(envelope) end

---[BR] Delete envelope point by index (zero-based) in the envelope object allocated with BR_EnvAlloc.
---@param envelope BR_Envelope
---@param id integer
---@return boolean retval
function reaper.BR_EnvDeletePoint(envelope, id) end

---[BR] Find envelope point at time position in the envelope object allocated with BR_EnvAlloc. Pass delta > 0 to search surrounding range - in that case the closest point to position within delta will be searched for. Returns envelope point id (zero-based) on success or -1 on failure.
---@param envelope BR_Envelope
---@param position number
---@param delta number
---@return integer retval
function reaper.BR_EnvFind(envelope, position, delta) end

---[BR] Find next envelope point after time position in the envelope object allocated with BR_EnvAlloc. Returns envelope point id (zero-based) on success or -1 on failure.
---@param envelope BR_Envelope
---@param position number
---@return integer retval
function reaper.BR_EnvFindNext(envelope, position) end

---[BR] Find previous envelope point before time position in the envelope object allocated with BR_EnvAlloc. Returns envelope point id (zero-based) on success or -1 on failure.
---@param envelope BR_Envelope
---@param position number
---@return integer retval
function reaper.BR_EnvFindPrevious(envelope, position) end

---[BR] Free envelope object allocated with BR_EnvAlloc and commit changes if needed. Returns true if changes were committed successfully. Note that when envelope object wasn't modified nothing will get committed even if commit = true - in that case function returns false.
---@param envelope BR_Envelope
---@param commit boolean
---@return boolean retval
function reaper.BR_EnvFree(envelope, commit) end

---[BR] If envelope object allocated with BR_EnvAlloc is take envelope, returns parent media item take, otherwise NULL.
---@param envelope BR_Envelope
---@return MediaItem_Take take
function reaper.BR_EnvGetParentTake(envelope) end

---[BR] Get parent track of envelope object allocated with BR_EnvAlloc. If take envelope, returns NULL.
---@param envelope BR_Envelope
---@return MediaTrack tr
function reaper.BR_EnvGetParentTrack(envelope) end

---[BR] Get envelope point by id (zero-based) from the envelope object allocated with BR_EnvAlloc. Returns true on success.
---@param envelope BR_Envelope
---@param id integer
---@return boolean retval, number position, number value, integer shape, boolean selected, number bezier
function reaper.BR_EnvGetPoint(envelope, id) end

---[BR] Get envelope properties for the envelope object allocated with BR_EnvAlloc.active: true if envelope is active
---visible: true if envelope is visible
---armed: true if envelope is armed
---inLane: true if envelope has it's own envelope lane
---laneHeight: envelope lane override height. 0 for none, otherwise size in pixels
---defaultShape: default point shape: 0->Linear, 1->Square, 2->Slow start/end, 3->Fast start, 4->Fast end, 5->Bezier
---minValue: minimum envelope value
---maxValue: maximum envelope value
---type: envelope type: 0->Volume, 1->Volume (Pre-FX), 2->Pan, 3->Pan (Pre-FX), 4->Width, 5->Width (Pre-FX), 6->Mute, 7->Pitch, 8->Playrate, 9->Tempo map, 10->Parameter
---faderScaling: true if envelope uses fader scaling
---automationItemsOptions: -1->project default, &1=0->don't attach to underl. env., &1->attach to underl. env. on right side, &2->attach to underl. env. on both sides, &4: bypass underl. env.
---@param envelope BR_Envelope
---@return boolean active, boolean visible, boolean armed, boolean inLane, integer laneHeight, integer defaultShape, number minValue, number maxValue, number centerValue, integer type, boolean faderScaling, integer|nil automationItemsOptions
function reaper.BR_EnvGetProperties(envelope) end

---[BR] Set envelope point by id (zero-based) in the envelope object allocated with BR_EnvAlloc. To create point instead, pass id = -1. Note that if new point is inserted or existing point's time position is changed, points won't automatically get sorted. To do that, see BR_EnvSortPoints.
---Returns true on success.
---@param envelope BR_Envelope
---@param id integer
---@param position number
---@param value number
---@param shape integer
---@param selected boolean
---@param bezier number
---@return boolean retval
function reaper.BR_EnvSetPoint(envelope, id, position, value, shape, selected, bezier) end

---[BR] Set envelope properties for the envelope object allocated with BR_EnvAlloc. For parameter description see BR_EnvGetProperties.Setting automationItemsOptions requires REAPER 5.979+.
---@param envelope BR_Envelope
---@param active boolean
---@param visible boolean
---@param armed boolean
---@param inLane boolean
---@param laneHeight integer
---@param defaultShape integer
---@param faderScaling boolean
---@param automationItemsOptions? integer
function reaper.BR_EnvSetProperties(envelope, active, visible, armed, inLane, laneHeight, defaultShape, faderScaling, automationItemsOptions) end

---[BR] Sort envelope points by position. The only reason to call this is if sorted points are explicitly needed after editing them with BR_EnvSetPoint. Note that you do not have to call this before doing BR_EnvFree since it does handle unsorted points too.
---@param envelope BR_Envelope
function reaper.BR_EnvSortPoints(envelope) end

---[BR] Get envelope value at time position for the envelope object allocated with BR_EnvAlloc.
---@param envelope BR_Envelope
---@param position number
---@return number retval
function reaper.BR_EnvValueAtPos(envelope, position) end

---[BR] Deprecated, see GetSet_ArrangeView2 (REAPER v5.12pre4+)Get start and end time position of arrange view. To set arrange view instead, see BR_SetArrangeView.
---@param proj ReaProject
---@return number|nil retval, number endTime
function reaper.BR_GetArrangeView(proj) end

---[BR] Get closest grid division to position. Note that this functions is different from SnapToGrid in two regards. SnapToGrid() needs snap enabled to work and this one works always. 
---Secondly, grid divisions are different from grid lines because some grid lines may be hidden due to zoom level - this function ignores grid line visibility and always searches for the closest grid division at given position. For more grid division functions, see BR_GetNextGridDivision and BR_GetPrevGridDivision.
---@param position number
---@return number retval
function reaper.BR_GetClosestGridDivision(position) end

---[BR] Get current theme information. themePathOut is set to full theme path and themeNameOut is set to theme name excluding any path info and extension
---@return string themePath, string themeName
function reaper.BR_GetCurrentTheme() end

---[BR] Get media item from GUID string. Note that the GUID must be enclosed in braces {}. To get item's GUID as a string, see BR_GetMediaItemGUID.
---@param proj ReaProject
---@param guidString string
---@return MediaItem item
function reaper.BR_GetMediaItemByGUID(proj, guidString) end

---[BR] Get media item GUID as a string (guidStringOut_sz should be at least 64). To get media item back from GUID string, see [BR\_GetMediaItemByGUID](#BR_GetMediaItemByGUID).
---@param item MediaItem
---@return string guidString
function reaper.BR_GetMediaItemGUID(item) end

---[BR] Get currently loaded image resource and its flags for a given item. Returns false if there is no image resource set. To set image resource, see [BR\_SetMediaItemImageResource](#BR_SetMediaItemImageResource).
---@param item MediaItem
---@return boolean retval, string image, integer imageFlags
function reaper.BR_GetMediaItemImageResource(item) end

---[BR] Get media item take GUID as a string (guidStringOut_sz should be at least 64). To get take from GUID string, see [SNM\_GetMediaItemTakeByGUID](#SNM_GetMediaItemTakeByGUID).
---@param take MediaItem_Take
---@return string guidString
function reaper.BR_GetMediaItemTakeGUID(take) end

---[BR] Get take media source properties as they appear in Item properties. Returns false if take can't have them (MIDI items etc.).
---To set source properties, see [BR\_SetMediaSourceProperties](#BR_SetMediaSourceProperties).
---@param take MediaItem_Take
---@return boolean retval, boolean section, number start, number length, number fade, boolean reverse
function reaper.BR_GetMediaSourceProperties(take) end

---[BR] Get media track from GUID string. Note that the GUID must be enclosed in braces {}. To get track's GUID as a string, see [GetSetMediaTrackInfo\_String](#GetSetMediaTrackInfo_String).
---@param proj ReaProject
---@param guidString string
---@return MediaTrack tr
function reaper.BR_GetMediaTrackByGUID(proj, guidString) end

---[BR] Get media track freeze count (if track isn't frozen at all, returns 0).
---@param track MediaTrack
---@return integer retval
function reaper.BR_GetMediaTrackFreezeCount(track) end

---[BR] Deprecated, see [GetSetMediaTrackInfo\_String](#GetSetMediaTrackInfo_String) (v5.95+). Get media track GUID as a string (guidStringOut\_sz should be at least 64). To get media track back from GUID string, see [BR\_GetMediaTrackByGUID](#BR_GetMediaTrackByGUID).
---@param track MediaTrack
---@return string guidString
function reaper.BR_GetMediaTrackGUID(track) end

---[BR] Deprecated, see [GetSetMediaTrackInfo](#GetSetMediaTrackInfo) (REAPER v5.02+). Get media track layouts for MCP and TCP. Empty string ("") means that layout is set to the default layout. To set media track layouts, see [BR\_SetMediaTrackLayouts](#BR_SetMediaTrackLayouts).
---@param track MediaTrack
---@return string mcpLayoutName, string tcpLayoutName
function reaper.BR_GetMediaTrackLayouts(track) end

---[BR] Get track envelope for send/receive/hardware output.category is <0 for receives, 0=sends, >0 for hardware outputs
---sendidx is zero-based (see [GetTrackNumSends](#GetTrackNumSends) to count track sends/receives/hardware outputs)
---envelopeType determines which envelope is returned (0=volume, 1=pan, 2=mute)Note: To get or set other send attributes, see [BR\_GetSetTrackSendInfo](#BR_GetSetTrackSendInfo) and [BR\_GetMediaTrackSendInfo\_Track](#BR_GetMediaTrackSendInfo_Track).
---@param track MediaTrack
---@param category integer
---@param sendidx integer
---@param envelopeType integer
---@return TrackEnvelope env
function reaper.BR_GetMediaTrackSendInfo_Envelope(track, category, sendidx, envelopeType) end

---[BR] Get source or destination media track for send/receive.category is <0 for receives, 0=sends
---sendidx is zero-based (see [GetTrackNumSends](#GetTrackNumSends) to count track sends/receives)
---trackType determines which track is returned (0=source track, 1=destination track)Note: To get or set other send attributes, see [BR\_GetSetTrackSendInfo](#BR_GetSetTrackSendInfo) and [BR\_GetMediaTrackSendInfo_Envelope](#BR_GetMediaTrackSendInfo_Envelope).
---@param track MediaTrack
---@param category integer
---@param sendidx integer
---@param trackType integer
---@return MediaTrack tr
function reaper.BR_GetMediaTrackSendInfo_Track(track, category, sendidx, trackType) end

---[BR] Get MIDI take source length in PPQ. In case the take isn't MIDI, return value will be -1.
---@param take MediaItem_Take
---@return number retval
function reaper.BR_GetMidiSourceLenPPQ(take) end

---[BR] Get MIDI take pool GUID as a string (guidStringOut_sz should be at least 64). Returns true if take is pooled.
---@param take MediaItem_Take
---@return boolean retval, string guidString
function reaper.BR_GetMidiTakePoolGUID(take) end

---[BR] Get "ignore project tempo" information for MIDI take. Returns true if take can ignore project tempo (no matter if it's actually ignored), otherwise false.
---@param take MediaItem_Take
---@return boolean retval, boolean ignoreProjTempo, number bpm, integer num, integer den
function reaper.BR_GetMidiTakeTempoInfo(take) end

---[BR] Get mouse cursor context. Each parameter returns information in a form of string as specified in the table below.To get more info on stuff that was found under mouse cursor see [BR\_GetMouseCursorContext\_Envelope](#BR_GetMouseCursorContext_Envelope), [BR\_GetMouseCursorContext\_Item](#BR_GetMouseCursorContext_Item), [BR\_GetMouseCursorContext\_MIDI](#BR_GetMouseCursorContext_MIDI), [BR\_GetMouseCursorContext\_Position](#BR_GetMouseCursorContext_Position), [BR\_GetMouseCursorContext\_Take](#BR_GetMouseCursorContext_Take), [BR\_GetMouseCursorContext\_Track](#BR_GetMouseCursorContext_Track)
---<table border='2'>
---<tr><th style='width:100px'>Window</th><th style='width:100px'>Segment</th><th style='width:300px'>Details</th></tr>
---<tr><th rowspan='1' align = 'center'>unknown</th><td>""</td><td>""</td></tr>
---<tr><th rowspan='4' align = 'center'>ruler</th><td>region\_lane </td><td>""</td></tr>
---<tr><td>marker\_lane </td><td>""</td></tr>
---<tr><td>tempo\_lane </td><td>""</td></tr>
---<tr><td>timeline</td><td>""</td></tr>
---<tr><th rowspan='1' align = 'center'>transport</th><td>""</td><td>""</td></tr>
---<tr><th rowspan='3' align = 'center'>tcp </th><td>track</td><td>""</td></tr>
---<tr><td>envelope</td><td>""</td></tr>
---<tr><td>empty</td><td>""</td></tr>
---<tr><th rowspan='2' align = 'center'>mcp </th><td>track</td><td>""</td></tr>
---<tr><td>empty</td><td>""</td></tr>
---<tr><th rowspan='3' align = 'center'>arrange</th><td>track</td><td>empty,item, item\_stretch\_marker,env\_point, env\_segment </td></tr>
---<tr><td>envelope</td><td>empty, env\_point, env\_segment</td></tr>
---<tr><td>empty</td><td>""</td></tr>
---<tr><th rowspan='5' align = 'center'>midi\_editor </th><td>unknown</td><td>""</td></tr>
---<tr><td>ruler</td><td>""</td></tr>
---<tr><td>piano</td><td>""</td></tr>
---<tr><td>notes</td><td>""</td></tr>
---<tr><td>cc\_lane</td><td>cc\_selector, cc\_lane</td></tr>
---</table>
---@return string window, string segment, string details
function reaper.BR_GetMouseCursorContext() end

---[BR] Returns envelope that was captured with the last call to [BR\_GetMouseCursorContext](#BR_GetMouseCursorContext). In case the envelope belongs to take, takeEnvelope will be true.
---@return TrackEnvelope retval, boolean takeEnvelope
function reaper.BR_GetMouseCursorContext_Envelope() end

---[BR] Returns item under mouse cursor that was captured with the last call to [BR\_GetMouseCursorContext](#BR_GetMouseCursorContext). Note that the function will return item even if mouse cursor is over some other track lane element like stretch marker or envelope. This enables for easier identification of items when you want to ignore elements within the item.
---@return MediaItem item
function reaper.BR_GetMouseCursorContext_Item() end

---[BR] Returns midi editor under mouse cursor that was captured with the last call to [BR\_GetMouseCursorContext](#BR_GetMouseCursorContext).inlineEditor: if mouse was captured in inline MIDI editor, this will be true (consequentially, returned MIDI editor will be NULL)
---noteRow: note row or piano key under mouse cursor (0-127)
---ccLane: CC lane under mouse cursor (CC0-127=CC, 0x100|(0-31)=14-bit CC, 0x200=velocity, 0x201=pitch, 0x202=program, 0x203=channel pressure, 0x204=bank/program select, 0x205=text, 0x206=sysex, 0x207=off velocity, 0x208=notation events)
---ccLaneVal: value in CC lane under mouse cursor (0-127 or 0-16383)
---ccLaneId: lane position, counting from the top (0 based)Note: due to API limitations, if mouse is over inline MIDI editor with some note rows hidden, noteRow will be -1
---@return identifier retval, boolean inlineEditor, integer noteRow, integer ccLane, integer ccLaneVal, integer ccLaneId
function reaper.BR_GetMouseCursorContext_MIDI() end

---[BR] Returns project time position in arrange/ruler/midi editor that was captured with the last call to [BR\_GetMouseCursorContext](#BR_GetMouseCursorContext).
---@return number retval
function reaper.BR_GetMouseCursorContext_Position() end

---[BR] Returns id of a stretch marker under mouse cursor that was captured with the last call to [BR\_GetMouseCursorContext](#BR_GetMouseCursorContext).
---@return integer retval
function reaper.BR_GetMouseCursorContext_StretchMarker() end

---[BR] Returns take under mouse cursor that was captured with the last call to [BR\_GetMouseCursorContext](#BR_GetMouseCursorContext).
---@return MediaItem_Take take
function reaper.BR_GetMouseCursorContext_Take() end

---[BR] Returns track under mouse cursor that was captured with the last call to [BR\_GetMouseCursorContext](#BR_GetMouseCursorContext).
---@return MediaTrack tr
function reaper.BR_GetMouseCursorContext_Track() end

---[BR] Get next grid division after the time position. For more grid divisions function, see [BR\_GetClosestGridDivision](#BR_GetClosestGridDivision) and [BR\_GetPrevGridDivision](#BR_GetPrevGridDivision).
---@param position number
---@return number retval
function reaper.BR_GetNextGridDivision(position) end

---[BR] Get previous grid division before the time position. For more grid division functions, see [BR\_GetClosestGridDivision](#BR_GetClosestGridDivision) and [BR\_GetNextGridDivision](#BR_GetNextGridDivision).
---@param position number
---@return number retval
function reaper.BR_GetPrevGridDivision(position) end

---[BR] Get or set send attributes.category is <0 for receives, 0=sends, >0 for hardware outputs
---sendidx is zero-based (see GetTrackNumSends to count track sends/receives/hardware outputs)
---To set attribute, pass setNewValue as trueList of possible parameters:   B_MUTE : send mute state (1.0 if muted, otherwise 0.0)
---   B_PHASE : send phase state (1.0 if phase is inverted, otherwise 0.0)
---   B_MONO : send mono state (1.0 if send is set to mono, otherwise 0.0)
---   D_VOL : send volume (1.0=+0dB etc...)
---   D_PAN : send pan (-1.0=100%L, 0=center, 1.0=100%R)
---   D_PANLAW : send pan law (1.0=+0.0db, 0.5=-6dB, -1.0=project default etc...)
---   I_SENDMODE : send mode (0=post-fader, 1=pre-fx, 2=post-fx(deprecated), 3=post-fx)
---   I_SRCCHAN : audio source starting channel index or -1 if audio send is disabled (&1024=mono...note that in that case, when reading index, you should do (index XOR 1024) to get starting channel index)
---   I_DSTCHAN : audio destination starting channel index (&1024=mono (and in case of hardware output &512=rearoute)...note that in that case, when reading index, you should do (index XOR (1024 OR 512)) to get starting channel index)
---   I_MIDI_SRCCHAN : source MIDI channel, -1 if MIDI send is disabled (0=all, 1-16)
---   I_MIDI_DSTCHAN : destination MIDI channel, -1 if MIDI send is disabled (0=original, 1-16)
---   I_MIDI_SRCBUS : source MIDI bus, -1 if MIDI send is disabled (0=all, otherwise bus index)
---   I_MIDI_DSTBUS : receive MIDI bus, -1 if MIDI send is disabled (0=all, otherwise bus index)
---   I_MIDI_LINK_VOLPAN : link volume/pan controls to MIDINote: To get or set other send attributes, see [BR\_GetMediaTrackSendInfo\_Envelope](#BR_GetMediaTrackSendInfo_Envelope) and [BR\_GetMediaTrackSendInfo\_Track](#BR_GetMediaTrackSendInfo_Track).
---@param track MediaTrack
---@param category integer
---@param sendidx integer
---@param parmname string
---@param setNewValue boolean
---@param newValue number
---@return number value
function reaper.BR_GetSetTrackSendInfo(track, category, sendidx, parmname, setNewValue, newValue) end

---[BR] Returns FX count for supplied take
---@param take MediaItem_Take
---@return integer retval
function reaper.BR_GetTakeFXCount(take) end

---[SWS] Check if take has MIDI inline editor open and returns true or false.
---@param take MediaItem_Take
---@return boolean retval
function reaper.BR_IsMidiOpenInInlineEditor(take) end

---[BR] Check if take is MIDI take, in case MIDI take is in-project MIDI source data, inProjectMidiOut will be true, otherwise false.
---@param take MediaItem_Take
---@return boolean retval, boolean inProjectMidi
function reaper.BR_IsTakeMidi(take) end

---[BR] Get media item under mouse cursor. Position is mouse cursor position in arrange.
---@return MediaItem item, number position
function reaper.BR_ItemAtMouseCursor() end

---[BR] Remove CC lane in midi editor. Top visible CC lane is laneId 0. Returns true on success
---@param midiEditor identifier
---@param laneId integer
---@return boolean retval
function reaper.BR_MIDI_CCLaneRemove(midiEditor, laneId) end

---[BR] Replace CC lane in midi editor. Top visible CC lane is laneId 0. Returns true on success.
---Valid CC lanes: CC0-127=CC, 0x100|(0-31)=14-bit CC, 0x200=velocity, 0x201=pitch, 0x202=program, 0x203=channel pressure, 0x204=bank/program select, 0x205=text, 0x206=sysex, 0x207
---@param midiEditor identifier
---@param laneId integer
---@param newCC integer
---@return boolean retval
function reaper.BR_MIDI_CCLaneReplace(midiEditor, laneId, newCC) end

---[BR] Get position at mouse cursor. To check ruler along with arrange, pass checkRuler=true. Returns -1 if cursor is not over arrange/ruler.
---@param checkRuler boolean
---@return number position
function reaper.BR_PositionAtMouseCursor(checkRuler) end

---[BR] Deprecated, see [GetSet\_ArrangeView2](#GetSet_ArrangeView2) (REAPER v5.12pre4+) -- Set start and end time position of arrange view. To get arrange view instead, see [BR\_GetArrangeView](#BR_GetArrangeView).
---@param proj ReaProject
---@param startTime number
---@param endTime number
function reaper.BR_SetArrangeView(proj, startTime, endTime) end

---[BR] Set item start and end edges' position - returns true in case of any changes
---@param item MediaItem
---@param startTime number
---@param endTime number
---@return boolean retval
function reaper.BR_SetItemEdges(item, startTime, endTime) end

---[BR] Set image resource and its flags for a given item. To clear current image resource, pass image as "".imageFlags: 
---&1=0: don't display image, 
---&1: center / tile, 
---&3: stretch, 
---&5: full height (REAPER 5.974+).Can also be used to display existing text in empty items unstretched (pass image = "", imageFlags = 0) or stretched (pass image = "". imageFlags = 3).To get image resource, see BR_GetMediaItemImageResource
---@param item MediaItem
---@param image string
---@param imageFlags integer
function reaper.BR_SetMediaItemImageResource(item, image, imageFlags) end

---[BR] Set take media source properties. Returns false if take can't have them (MIDI items etc.). Section parameters have to be valid only when passing section=true.
---To get source properties, see [BR\_GetMediaSourceProperties](#BR_GetMediaSourceProperties).
---@param take MediaItem_Take
---@param section boolean
---@param start number
---@param length number
---@param fade number
---@param reverse boolean
---@return boolean retval
function reaper.BR_SetMediaSourceProperties(take, section, start, length, fade, reverse) end

---[BR] Deprecated, see [GetSetMediaTrackInfo](#GetSetMediaTrackInfo) (REAPER v5.02+). Set media track layouts for MCP and TCP. To set default layout, pass empty string ("") as layout name. In case layouts were successfully set, returns true (if layouts are already set to supplied layout names, it will return false since no changes were made).
---To get media track layouts, see [BR\_GetMediaTrackLayouts](#BR_GetMediaTrackLayouts).
---@param track MediaTrack
---@param mcpLayoutName string
---@param tcpLayoutName string
---@return boolean retval
function reaper.BR_SetMediaTrackLayouts(track, mcpLayoutName, tcpLayoutName) end

---[BR] Set "ignore project tempo" information for MIDI take. Returns true in case the take was successfully updated.
---@param take MediaItem_Take
---@param ignoreProjTempo boolean
---@param bpm number
---@param num integer
---@param den integer
---@return boolean retval
function reaper.BR_SetMidiTakeTempoInfo(take, ignoreProjTempo, bpm, num, den) end

---[BR] Set new take source from file. To import MIDI file as in-project source data pass inProjectData=true. Returns false if failed.
---Any take source properties from the previous source will be lost - to preserve them, see [BR\_SetTakeSourceFromFile2](#BR_SetTakeSourceFromFile2).
---Note: To set source from existing take, see [SNM\_GetSetSourceState2](#SNM_GetSetSourceState2).
---@param take MediaItem_Take
---@param filename string
---@param inProjectData boolean
---@return boolean retval
function reaper.BR_SetTakeSourceFromFile(take, filename, inProjectData) end

---[BR] Differs from [BR\_SetTakeSourceFromFile](#BR_SetTakeSourceFromFile) only that it can also preserve existing take media source properties.
---@param take MediaItem_Take
---@param filename string
---@param inProjectData boolean
---@param keepSourceProperties boolean
---@return boolean retval
function reaper.BR_SetTakeSourceFromFile2(take, filename, inProjectData, keepSourceProperties) end

---[BR] Get take under mouse cursor. Position is mouse cursor position in arrange.
---@return MediaItem_Take take, number position
function reaper.BR_TakeAtMouseCursor() end

---[BR] Get track under mouse cursor.
---Context signifies where the track was found: 0 = TCP, 1 = MCP, 2 = Arrange.
---Position will hold mouse cursor position in arrange if applicable.
---@return MediaTrack retval, integer context, number position
function reaper.BR_TrackAtMouseCursor() end

---[BR] Deprecated, see TrackFX_GetNamedConfigParm/'fx_ident' (v6.37+). Get the exact name (like effect.dll, effect.vst3, etc...) of an FX.
---@param track MediaTrack
---@param fx integer
---@return boolean retval, string name
function reaper.BR_TrackFX_GetFXModuleName(track, fx) end

---[BR] Equivalent to win32 API GetPrivateProfileString(). For example, you can use this to get values from REAPER.iniIf you have multiple sections in that file with the same name, only the first one will be used, the rest will be ignored by Reaper.
---If you have multiple keys with the same name within a section, only the first one will be used, the rest will be ignored by Reaper.
---You can get the paths using [GetExePath](#GetExePath) for the Reaper-application-folder, [GetResourcePath](#GetResourcePath) for the ressources-folder or get\_ini\_file for the path+filename of the Reaper.ini-file.
---@param sectionName string
---@param keyName string
---@param defaultString string
---@param filePath string
---@return integer retval, string value
function reaper.BR_Win32_GetPrivateProfileString(sectionName, keyName, defaultString, filePath) end

---[BR] Equivalent to win32 API ShellExecute() with HWND set to main window
---@param operation string
---@param file string
---@param parameters string
---@param directory string
---@param showFlags integer
---@return integer retval
function reaper.BR_Win32_ShellExecute(operation, file, parameters, directory, showFlags) end

---[BR] Equivalent to win32 API WritePrivateProfileString(). For example, you can use this to write to REAPER.iniIf you have multiple sections in that file with the same name, only the first one will be used, the rest will be ignored by Reaper.
---If you have multiple keys with the same name within a section, only the first one will be used, the rest will be ignored by Reaper.
---You can get the paths using [GetExePath](#GetExePath) for the Reaper-application-folder, [GetResourcePath](#GetResourcePath) for the ressources-folder or [get\_ini\_file](#get_ini_file) for the path+filename of the Reaper.ini-file.You can pass an empty string as value to delete a key.Important: Don't use \n in parameter value, or the reread-value might be incomplete!
---@param sectionName string
---@param keyName string
---@param value string
---@param filePath string
---@return boolean retval
function reaper.BR_Win32_WritePrivateProfileString(sectionName, keyName, value, filePath) end

---Get session beat value corresponding to given time for given quantum.
---@param time number
---@param quantum number
---@return number retval
function reaper.Blink_GetBeatAtTime(time, quantum) end

---Clock used by Blink.
---@return number retval
function reaper.Blink_GetClockNow() end

---Is Blink currently enabled?
---@return boolean retval
function reaper.Blink_GetEnabled() end

---Is Blink Master?
---@return boolean retval
function reaper.Blink_GetMaster() end

---How many peers are currently connected in Link session?
---@return integer retval
function reaper.Blink_GetNumPeers() end

---Get session phase at given time for given quantum.
---@param time number
---@param quantum number
---@return number retval
function reaper.Blink_GetPhaseAtTime(time, quantum) end

---Is transport playing?
---@return boolean retval
function reaper.Blink_GetPlaying() end

---Is Blink Puppet?
---@return boolean retval
function reaper.Blink_GetPuppet() end

---Get quantum.
---@return number retval
function reaper.Blink_GetQuantum() end

---Is start/stop synchronization enabled?
---@return boolean retval
function reaper.Blink_GetStartStopSyncEnabled() end

---Tempo of timeline, in quarter note Beats Per Minute.
---@return number retval
function reaper.Blink_GetTempo() end

---Get time at which given beat occurs for given quantum.
---@param beat number
---@param quantum number
---@return number retval
function reaper.Blink_GetTimeAtBeat(beat, quantum) end

---Get time at which transport start/stop occurs.
---@return number retval
function reaper.Blink_GetTimeForPlaying() end

---Get Blink version.
---@return number retval
function reaper.Blink_GetVersion() end

---Convenience function to attempt to map given beat to time when transport is starting to play in context of given quantum. This function evaluates to a no-op if GetPlaying() equals false.
---@param beat number
---@param quantum number
function reaper.Blink_SetBeatAtStartPlayingTimeRequest(beat, quantum) end

---Rudely re-map beat/time relationship for all peers in Link session.
---@param bpm number
---@param time number
---@param quantum number
function reaper.Blink_SetBeatAtTimeForce(bpm, time, quantum) end

---Attempt to map given beat to given time in context of given quantum.
---@param bpm number
---@param time number
---@param quantum number
function reaper.Blink_SetBeatAtTimeRequest(bpm, time, quantum) end

---Captures REAPER Transport commands and 'Tempo: Increase/Decrease current project tempo by 01 BPM' commands and broadcasts them into Link session. When used with Master or Puppet mode enabled, provides better integration between REAPER and Link session transport and tempos.
---@param enable boolean
function reaper.Blink_SetCaptureTransportCommands(enable) end

---Enable/disable Blink. In Blink methods transport, tempo and timeline refer to Link session, not local REAPER instance.
---@param enable boolean
function reaper.Blink_SetEnabled(enable) end

---Set Blink as Master. Puppet needs to be enabled first. Same as Puppet, but possible beat offset is broadcast to Link session, effectively forcing local REAPER timeline on peers. Only one, if any, Blink should be Master in Link session.
---@param enable boolean
function reaper.Blink_SetMaster(enable) end

---Set if transport should be playing or stopped, taking effect at given time.
---@param playing boolean
---@param time number
function reaper.Blink_SetPlaying(playing, time) end

---Convenience function to start or stop transport at given time and attempt to map given beat to this time in context of given quantum.
---@param playing boolean
---@param time number
---@param beat number
---@param quantum number
function reaper.Blink_SetPlayingAndBeatAtTimeRequest(playing, time, beat, quantum) end

---Set Blink as Puppet. When enabled, Blink attempts to synchronize local REAPER tempo to Link session tempo by adjusting current active tempo/time signature marker, or broadcasts local REAPER tempo changes into Link session, and attempts to correct possible offset by adjusting REAPER playrate. Based on cumulative single beat phase since Link session transport start, regardless of quantum.
---@param enable boolean
function reaper.Blink_SetPuppet(enable) end

---Set quantum. Usually this is set to length of one measure/bar in quarter notes.
---@param quantum number
function reaper.Blink_SetQuantum(quantum) end

---Enable start/stop synchronization.
---@param enable boolean
function reaper.Blink_SetStartStopSyncEnabled(enable) end

---Set timeline tempo to given bpm value.
---@param bpm number
function reaper.Blink_SetTempo(bpm) end

---Set tempo to given bpm value, taking effect at given time.
---@param bpm number
---@param time number
function reaper.Blink_SetTempoAtTime(bpm, time) end

---Transport start/stop.
function reaper.Blink_StartStop() end

---Get one of 16 SWS custom colors (0xBBGGRR on Windows, 0xRRGGBB everyhwere else). Index is zero-based.
---@param index integer
---@return integer retval
function reaper.CF_GetCustomColor(index) end

---Set one of 16 SWS custom colors (0xBBGGRR on Windows, 0xRRGGBB everyhwere else). Index is zero-based. 
---@param index integer
---@param color integer
function reaper.CF_SetCustomColor(index, color) end

---Deletes a take from an item. takeIdx is zero-based. Returns true on success.
---@param item MediaItem
---@param takeIdx integer
---@return boolean retval
function reaper.NF_DeleteTakeFromItem(item, takeIdx) end

---Read the contents of the system clipboard.
---@return string text
function reaper.CF_GetClipboard() end

---\[DEPRECATED: Use [CF\_GetClipboard](#CF_GetClipboard)\] Read the contents of the system clipboard. See [SNM\_CreateFastString](#SNM_CreateFastString) and [SNM\_DeleteFastString](#SNM_DeleteFastString).
---@param output WDL_FastString
---@return string clipboard_content
function reaper.CF_GetClipboardBig(output) end

---Write the given string into the system clipboard.
---@param str string
function reaper.CF_SetClipboard(str) end

---[FNG]Add MIDI note to MIDI take
---@param midiTake RprMidiTake
---@return RprMidiNote note
function reaper.FNG_AddMidiNote(midiTake) end

---[FNG]Allocate a RprMidiTake from a take pointer. Returns a NULL pointer if the take is not an in-project MIDI take
---@param take MediaItem_Take
---@return RprMidiTake rpr_take
function reaper.FNG_AllocMidiTake(take) end

---[FNG]Count of how many MIDI notes are in the MIDI take
---@param midiTake RprMidiTake
---@return integer retval
function reaper.FNG_CountMidiNotes(midiTake) end

---[FNG]Commit changes to MIDI take and free allocated memory
---@param midiTake RprMidiTake
function reaper.FNG_FreeMidiTake(midiTake) end

---[FNG]Get a MIDI note from a MIDI take at specified index
---@param midiTake RprMidiTake
---@param index integer
---@return RprMidiNote note
function reaper.FNG_GetMidiNote(midiTake, index) end

---[FNG]Get MIDI note property
---@param midiNote RprMidiNote
---@param property string
---@return integer retval
function reaper.FNG_GetMidiNoteIntProperty(midiNote, property) end

---[FNG]Set MIDI note property
---@param midiNote RprMidiNote
---@param property string
---@param value integer
function reaper.FNG_SetMidiNoteIntProperty(midiNote, property, value) end

---Full loudness analysis. retval: returns true on successful analysis, false on MIDI take or when analysis failed for some reason. analyzeTruePeak=true: Also do true peak analysis. Returns true peak value in dBTP and true peak position (relative to item position). Considerably slower than without true peak analysis (since it uses oversampling). Note: Short term uses a time window of 3 sec. for calculation. So for items shorter than this shortTermMaxOut can't be calculated correctly. Momentary uses a time window of 0.4 sec.
---@param take MediaItem_Take
---@param analyzeTruePeak boolean
---@return boolean retval, number lufsIntegrated, number range, number truePeak, number truePeakPos, number shortTermMax, number momentaryMax
function reaper.NF_AnalyzeTakeLoudness(take, analyzeTruePeak) end

---Decodes a Base64-string.Returns true on success.
---@param base64Str string
---@return boolean retval, string decodedStr
function reaper.NF_Base64_Decode(base64Str) end

---Encodes a string into Base64-encodingInput string may contain null bytes in REAPER 6.44 or newer. Note: Doesn't allow padding in the middle (e.g. concatenated encoded strings), doesn't allow newlines.
---@param str string
---@param usePadding boolean
---@return string encodedStr
function reaper.NF_Base64_Encode(str, usePadding) end

---Returns true if global startup action was cleared successfully.
---@return boolean retval
function reaper.NF_ClearGlobalStartupAction() end

---Returns true if project startup action was cleared successfully.
---@return boolean retval
function reaper.NF_ClearProjectStartupAction() end

---Returns true if project track selection action was cleared successfully.
---@return boolean retval
function reaper.NF_ClearProjectTrackSelectionAction() end

---Gets action description and command ID number (for native actions) or named command IDs / identifier strings (for extension actions /ReaScripts) if global startup action is set, otherwise empty string. Returns false on failure.
---@return boolean retval, string desc, string cmdId
function reaper.NF_GetGlobalStartupAction() end

---Same as [NF\_AnalyzeTakeLoudness](#NF_AnalyzeTakeLoudness) but additionally returns shortTermMaxPos and momentaryMaxPos (in absolute project time). Note: shortTermMaxPos and momentaryMaxPos actually indicate the beginning of time *intervalls*, (3 sec. and 0.4 sec. resp.). 
---@param take MediaItem_Take
---@param analyzeTruePeak boolean
---@return boolean retval, number lufsIntegrated, number range, number truePeak, number truePeakPos, number shortTermMax, number momentaryMax, number shortTermMaxPos, number momentaryMaxPos
function reaper.NF_AnalyzeTakeLoudness2(take, analyzeTruePeak) end

---Does LUFS integrated analysis only. Faster than full loudness analysis ([NF\_AnalyzeTakeLoudness](#NF_AnalyzeTakeLoudness)) . Use this if only LUFS integrated is required.
---Take vol. env. is taken into account. See: [Signal flow](http://wiki.cockos.com/wiki/index.php/Measure_and_normalize_loudness_with_SWS).
---
---@param take MediaItem_Take
---@return boolean retval, number lufsIntegrated
function reaper.NF_AnalyzeTakeLoudness_IntegratedOnly(take) end

---Returns the average overall (non-windowed) dB RMS level of active channels of an audio item active take, post item gain, post take volume envelope, post-fade, pre fader, pre item FX. 
---Returns -150.0 if MIDI take or empty item.
---@param item MediaItem
---@return number retval
function reaper.NF_GetMediaItemAverageRMS(item) end

---Returns the greatest max. peak value in dBFS of all active channels of an audio item active take, post item gain, post take volume envelope, post-fade, pre fader, pre item FX. 
---Returns -150.0 if MIDI take or empty item.
---@param item MediaItem
---@return number retval
function reaper.NF_GetMediaItemMaxPeak(item) end

---Returns the greatest overall (non-windowed) dB RMS peak level of all active channels of an audio item active take, post item gain, post take volume envelope, post-fade, pre fader, pre item FX. 
---Returns -150.0 if MIDI take or empty item.
---@param item MediaItem
---@return number retval
function reaper.NF_GetMediaItemPeakRMS_NonWindowed(item) end

---Returns the average dB RMS peak level of all active channels of an audio item active take, post item gain, post take volume envelope, post-fade, pre fader, pre item FX. 
---Obeys 'Window size for peak RMS' setting in 'SWS: Set RMS analysis/normalize options' for calculation. Returns -150.0 if MIDI take or empty item.
---@param item MediaItem
---@return number retval
function reaper.NF_GetMediaItemPeakRMS_Windowed(item) end

---Gets action description and command ID number (for native actions) or named command IDs / identifier strings (for extension actions /ReaScripts) if project startup action is set, otherwise empty string. Returns false on failure.
---@return boolean retval, string desc, string cmdId
function reaper.NF_GetProjectStartupAction() end

---Gets action description and command ID number (for native actions) or named command IDs / identifier strings (for extension actions /ReaScripts) if project track selection action is set, otherwise empty string. Returns false on failure.
---@return boolean retval, string desc, string cmdId
function reaper.NF_GetProjectTrackSelectionAction() end

---Returns the bitrate of an audio file in kb/s if available (0 otherwise). For supported filetypes see <a href="https://taglib.org/api/classTagLib_1_1AudioProperties.html#ae5b7650b50f8c8f8cc022f25cfee48c5">TagLib::AudioProperties::bitrate</a>.
---@param fn string
---@return integer retval
function reaper.NF_ReadAudioFileBitrate(fn) end

---100 means scroll one page. Negative values scroll left.
---@param amount integer
function reaper.NF_ScrollHorizontallyByPercentage(amount) end

---Returns true if global startup action was set successfully (i.e. valid action ID). Note: For SWS / S&M actions and macros / scripts, you must use identifier strings (e.g. "_SWS_ABOUT", "_f506bc780a0ab34b8fdedb67ed5d3649"), not command IDs (e.g. "47145").
---Tip: to copy such identifiers, right-click the action in the Actions window > Copy selected action cmdID / identifier string.
---NOnly works for actions / scripts from Main action section.
---@param str string
---@return boolean retval
function reaper.NF_SetGlobalStartupAction(str) end

---Returns true if project startup action was set successfully (i.e. valid action ID). Note: For SWS / S&M actions and macros / scripts, you must use identifier strings (e.g. "_SWS_ABOUT", "_f506bc780a0ab34b8fdedb67ed5d3649"), not command IDs (e.g. "47145").
---Tip: to copy such identifiers, right-click the action in the Actions window > Copy selected action cmdID / identifier string.
---Only works for actions / scripts from Main action section. Project must be saved after setting project startup action to be persistent.
---@param str string
---@return boolean retval
function reaper.NF_SetProjectStartupAction(str) end

---Returns true if project track selection action was set successfully (i.e. valid action ID). Note: For SWS / S&M actions and macros / scripts, you must use identifier strings (e.g. "_SWS_ABOUT", "_f506bc780a0ab34b8fdedb67ed5d3649"), not command IDs (e.g. "47145").
---Tip: to copy such identifiers, right-click the action in the Actions window > Copy selected action cmdID / identifier string.
---Only works for actions / scripts from Main action section. Project must be saved after setting project track selection action to be persistent.
---@param str string
---@return boolean retval
function reaper.NF_SetProjectTrackSelectionAction(str) end

---Deprecated, see TakeFX_GetNamedConfigParm/'fx_ident' (v6.37+). See BR_TrackFX_GetFXModuleName. fx: counted consecutively across all takes (zero-based).
---@param item MediaItem
---@param fx integer
---@return boolean retval, string name
function reaper.NF_TakeFX_GetFXModuleName(item, fx) end

---\[S&M\] Deprecated, see [CreateTrackSend](#CreateTrackSend) (v5.15pre1+). Adds a receive. Returns false if nothing updated.
---type -1=Default type (user preferences), 0=Post-Fader (Post-Pan), 1=Pre-FX, 2=deprecated, 3=Pre-Fader (Post-FX).
---Note: obeys default sends preferences, supports frozen tracks, etc..
---@param src MediaTrack
---@param dest MediaTrack
---@param type integer
---@return boolean retval
function reaper.SNM_AddReceive(src, dest, type) end

---[S&M] Add an FX parameter knob in the TCP. Returns false if nothing updated (invalid parameters, knob already present, etc..)
---@param tr MediaTrack
---@param fxId integer
---@param prmId integer
---@return boolean retval
function reaper.SNM_AddTCPFXParm(tr, fxId, prmId) end

---\[S&M\] Instantiates a new "fast string". You must delete this string, see [SNM\_DeleteFastString](#SNM_DeleteFastString).
---@param str string
---@return WDL_FastString fstr
function reaper.SNM_CreateFastString(str) end

---[S&M] Deletes a "fast string" instance.
---@param str WDL_FastString
function reaper.SNM_DeleteFastString(str) end

---[S&M] Returns a floating-point preference (look in project prefs first, then in general prefs). Returns errvalue if failed (e.g. varname not found).The settings can be from the Preferences, Project settings and Render-dialog, as well as numerous other settings, as e.g. set in the context menu of the transport-area.
---Some variables are bitfields, where each bit represents e.g a checkbox in the preferences.see <a ="Reaper_Config_Variables.html">Reaper Config Variables</a> for valid config-vars
---@param varname string
---@param errvalue number
---@return number retval
function reaper.SNM_GetDoubleConfigVar(varname, errvalue) end

---[S&M] Gets the "fast string" content.
---@param str WDL_FastString
---@return string str
function reaper.SNM_GetFastString(str) end

---[S&M] Gets the "fast string" length.
---@param str WDL_FastString
---@return integer retval
function reaper.SNM_GetFastStringLength(str) end

---[S&M] Returns an integer preference (look in project prefs first, then in general prefs). Returns errvalue if failed (e.g. varname not found).The settings can be from the Preferences, Project settings and Render-dialog, as well as numerous other settings, as e.g. set in the context menu of the transport-area.
---Some variables are bitfields, where each bit represents e.g a checkbox in the preferences.see <a href="Reaper_Config_Variables.html">Reaper Config Variables</a> for valid config-vars
---@param varname string
---@param errvalue integer
---@return integer retval
function reaper.SNM_GetIntConfigVar(varname, errvalue) end

---\[S&M\] Reads a 64-bit integer preference split in two 32-bit integers (look in project prefs first, then in general prefs). Returns false if failed (e.g. varname not found).see [Reaper Config Variables](Reaper_Config_Variables.html) for valid config-vars
---@param varname string
---@return boolean retval, integer high, integer low
function reaper.SNM_GetLongConfigVar(varname) end

---\[S&M\] Gets a take by GUID as string. The GUID must be enclosed in braces {}. To get take GUID as string, see [BR\_GetMediaItemTakeGUID](#BR_GetMediaItemTakeGUID)
---@param project ReaProject
---@param guid string
---@return MediaItem_Take take
function reaper.SNM_GetMediaItemTakeByGUID(project, guid) end

---[S&M] Gets a marker/region name. Returns true if marker/region found.
---@param proj ReaProject
---@param num integer
---@param isrgn boolean
---@param name WDL_FastString
---@return boolean retval
function reaper.SNM_GetProjectMarkerName(proj, num, isrgn, name) end

---[S&M] Gets or sets the state of a track, an item or an envelope. The state chunk size is unlimited. Returns false if failed.
---When getting a track state (and when you are not interested in FX data), you can use wantminimalstate=true to radically reduce the length of the state. Do not set such minimal states back though, this is for read-only applications!
---Note: unlike the native GetSetObjectState, calling to FreeHeapPtr() is not required.
---@param obj identifier
---@param state WDL_FastString
---@param setnewvalue boolean
---@param wantminimalstate boolean
---@return boolean retval
function reaper.SNM_GetSetObjectState(obj, state, setnewvalue, wantminimalstate) end

---\[S&M\] Gets or sets a take source state. Returns false if failed. Use takeidx=-1 to get/alter the active take.
---Note: this function does not use a MediaItem\_Take\* param in order to manage empty takes (i.e. takes with MediaItem\_Take\*==NULL), see [SNM\_GetSetSourceState2](#SNM_GetSetSourceState2).
---@param item MediaItem
---@param takeidx integer
---@param state WDL_FastString
---@param setnewvalue boolean
---@return boolean retval
function reaper.SNM_GetSetSourceState(item, takeidx, state, setnewvalue) end

---\[S&M\] Gets or sets a take source state. Returns false if failed.
---Note: this function cannot deal with empty takes, see [SNM\_GetSetSourceState](#SNM_GetSetSourceState).
---@param take MediaItem_Take
---@param state WDL_FastString
---@param setnewvalue boolean
---@return boolean retval
function reaper.SNM_GetSetSourceState2(take, state, setnewvalue) end

---[S&M] Deprecated, see [GetMediaSourceType](#GetMediaSourceType). Gets the source type of a take. Returns false if failed (e.g. take with empty source, etc..)
---@param type? MediaItem_Take
---@return boolean retval
function reaper.SNM_GetSourceType(type) end

---[S&M] Deprecated, see TakeFX_/TrackFX_ CopyToTrack/Take, TrackFX/TakeFX _Delete (v5.95pre2+). Move or removes a track FX. Returns true if tr has been updated.
---fxId: fx index in chain or -1 for the selected fx. what: 0 to remove, -1 to move fx up in chain, 1 to move fx down in chain.
---@param tr MediaTrack
---@param fxId integer
---@param what integer
---@return boolean retval
function reaper.SNM_MoveOrRemoveTrackFX(tr, fxId, what) end

---\[S&M\] Reads a media file tag. Supported tags: "artist", "album", "genre", "comment", "title", "track" (track number) or "year". Returns false if tag was not found. See [SNM\_TagMediaFile](#SNM_TagMediaFile).
---@param fn string
---@param tag string
---@return boolean retval, string tagval
function reaper.SNM_ReadMediaFileTag(fn, tag) end

---\[S&M\] Deprecated, see [RemoveTrackSend](#RemoveTrackSend) (v5.15pre1+). Removes a receive. Returns false if nothing updated.
---@param tr MediaTrack
---@param rcvidx integer
---@return boolean retval
function reaper.SNM_RemoveReceive(tr, rcvidx) end

---[S&M] Removes all receives from srctr. Returns false if nothing updated.
---@param tr MediaTrack
---@param srctr MediaTrack
---@return boolean retval
function reaper.SNM_RemoveReceivesFrom(tr, srctr) end

---[S&M] Select a bookmark of the Resources window. Returns the related bookmark id (or -1 if failed).
---@param name string
---@return integer retval
function reaper.SNM_SelectResourceBookmark(name) end

---[S&M] Sets a floating-point preference (look in project prefs first, then in general prefs). Returns false if failed (e.g. varname not found or newvalue out of range).The settings can be from the Preferences, Project settings and Render-dialog, as well as numerous other settings, as e.g. set in the context menu of the transport-area.
---Some variables are bitfields, where each bit represents e.g a checkbox in the preferences.The changed settings are usually only changed within the running Reaper, but not stored in the config-files, so you need to do it manually or they get lost after Reaper is closed!see <a hre="Reaper_Config_Variables.html">Reaper Config Variables</a> for valid config-vars
---@param varname string
---@param newvalue number
---@return boolean retval
function reaper.SNM_SetDoubleConfigVar(varname, newvalue) end

---[S&M] Sets the "fast string" content. Returns str for facility.
---@param str WDL_FastString
---@param newstr string
---@return WDL_FastString fstr
function reaper.SNM_SetFastString(str, newstr) end

---[S&M] Sets an integer preference (look in project prefs first, then in general prefs). Returns false if failed (e.g. varname not found).Some variables are bitfields, where each bit represents e.g a checkbox in the preferences.
---The changed settings are usually only changed within the running Reaper, but not stored in the config-files, so you need to do it manually or they get lost after Reaper is closed!see <a href="Reaper_Config_Variables.html">Reaper Config Variables</a> for valid config-vars
---@param varname string
---@param newvalue integer
---@return boolean retval
function reaper.SNM_SetIntConfigVar(varname, newvalue) end

---\[S&M\] Sets a 64-bit integer preference from two 32-bit integers (looks in project prefs first, then in general prefs). Returns false if failed (e.g. varname not found).Some variables are bitfields, where each bit represents e.g a checkbox in the preferences.
---The changed settings are usually only changed within the running Reaper, but not stored in the config-files, so you need to do it manually or they get lost after Reaper is closed!see [Reaper Config Variables](Reaper_Config_Variables.html) for valid config-vars
---@param varname string
---@param newHighValue integer
---@param newLowValue integer
---@return boolean retval
function reaper.SNM_SetLongConfigVar(varname, newHighValue, newLowValue) end

---\[S&M\] Deprecated, see [SetProjectMarker4](#SetProjectMarker4) -- Same function as SetProjectMarker3() except it can set empty names "".
---@param proj ReaProject
---@param num integer
---@param isrgn boolean
---@param pos number
---@param rgnend number
---@param name string
---@param color integer
---@return boolean retval
function reaper.SNM_SetProjectMarker(proj, num, isrgn, pos, rgnend, name, color) end

---[S&M] Sets a string preference (general prefs only). Returns false if failed (e.g. varname not found or value too long).see <a ="Reaper_Config_Variables.html">Reaper Config Variables</a> for valid config-vars
---@param varname string
---@param newvalue string
---@return boolean retval
function reaper.SNM_SetStringConfigVar(varname, newvalue) end

---\[S&M\] Tags a media file thanks to [TagLib](https://taglib.github.io). Use an empty tagval to clear a tag. When a file is opened in REAPER, turn it offline before using this function. Returns false if nothing updated. See [SNM\_ReadMediaFileTag](#SNM_ReadMediaFileTag).
---@param fn string
---@param tag string
---@param tagval string
---@return boolean retval
function reaper.SNM_TagMediaFile(fn, tag, tagval) end

---[S&M] Attach Resources slot actions to a given bookmark.
---@param bookmarkId integer
function reaper.SNM_TieResourceSlotActions(bookmarkId) end

---Focuses the active/open MIDI editor.
function reaper.SN_FocusMIDIEditor() end

---Deprecated[ULT] Deprecated, see [GetSetMediaItemInfo\_String](#GetSetMediaItemInfo_String) (v5.95+). Get item notes.
---@param item MediaItem
---@return string str
function reaper.ULT_GetMediaItemNote(item) end

---[ULT] Deprecated, see [GetSetMediaItemInfo\_String](#GetSetMediaItemInfo_String) (v5.95+). Set item notes.
---@param item MediaItem
---@param note string
function reaper.ULT_SetMediaItemNote(item, note) end

---Counts the shortcuts available for a specific action within a section.
---@param section integer
---@param cmdID integer
---@return integer retval
function reaper.JS_Actions_CountShortcuts(section, cmdID) end

---Deletes a shortcut of a specific action within a section.
---
---@param section integer
---@param cmdID integer
---@param shortcutidx integer
---@return boolean retval
function reaper.JS_Actions_DeleteShortcut(section, cmdID, shortcutidx) end

---Opens the do-shortcut-dialog, which allows you setting a shortcut for a specific action.If the shortcut index is higher than the current number of shortcuts, it will add a new shortcut.
---@param section integer
---@param cmdID integer
---@param shortcutidx integer
---@return boolean retval
function reaper.JS_Actions_DoShortcutDialog(section, cmdID, shortcutidx) end

---returns the description of a shortcut, as stored for a specific action within a section.This will be the shown representation of the shortcut as seen in the actionlist. That means, it is localized!
---@param section integer
---@param cmdID integer
---@param shortcutidx integer
---@return boolean retval, string desc
function reaper.JS_Actions_GetShortcutDesc(section, cmdID, shortcutidx) end

---Returns the unsigned byte at address[offset]. Offset is added as steps of 1 byte each.
---@param pointer identifier
---@param offset integer
---@return integer byte
function reaper.JS_Byte(pointer, offset) end

---Composites a LICE bitmap with a REAPER window. Each time that the window is re-drawn, the bitmap will be blitted over the window's client area (with per-pixel alpha blending).\* If dstw or dsth is -1, the bitmap will be stretched to fill the width or height of the window, respectively.\* autoUpdate is an optional parameter that is false by default. If true, JS\_Composite will automatically invalidate and re-draw the part of the window that covers the current position of the bitmap, and if the bitmap is being moved, also the previous position. (If only one or a handful of bitmaps are being moved across the screen, autoUpdate should result in smoother animation on WindowsOS; if numerous bitmaps are spread over the entire window, it may be faster to disable autoUpdate and instead call [JS\_Window\_InvalidateRect](#JS_Window_InvalidateRect) explicitly once all bitmaps have been moved.)\* InvalidateRect should also be called whenever the contents of the bitmap contents have been changed, but not the position, to trigger a window update.\* On WindowsOS, the key to reducing flickering is to slow down the frequency at which the window is re-drawn. InvalidateRect should only be called when absolutely necessary, preferably not more than 20 times per second. (Also refer to the [JS\_Composite\_Delay](#JS_Composite_Delay) function.)\* On WindowsOS, flickering can further be reduced by keeping the invalidated area as small as possible, covering only the bitmaps that have been edited or moved. However, if numerous bitmaps are spread over the entire window, it may be faster to simply invalidate the entire client area.\* This function should not be applied directly to top-level windows, but rather to child windows.\* Some classes of UI elements, particularly buttons, do not take kindly to being composited, and may crash REAPER.\* On WindowsOS, GDI blitting does not perform alpha multiplication of the source bitmap. For proper color rendering, a separate pre-multiplication step is therefore required, using either [LICE\_Blit](#LICE_Blit) or [LICE\_ProcessRect](#LICE_ProcessRect).Returns:
---1 if successful, otherwise -1 = windowHWND is not a window, -3 = Could not obtain the original window process, -4 = sysBitmap is not a LICE bitmap, -5 = sysBitmap is not a system bitmap, -6 = Could not obtain the window HDC, -7 = Error when subclassing to new window process.
---@param windowHWND identifier
---@param dstx integer
---@param dsty integer
---@param dstw integer
---@param dsth integer
---@param sysBitmap identifier
---@param srcx integer
---@param srcy integer
---@param srcw integer
---@param srch integer
---@param autoUpdate? boolean
---@return integer retval
function reaper.JS_Composite(windowHWND, dstx, dsty, dstw, dsth, sysBitmap, srcx, srcy, srcw, srch, autoUpdate) end

---On WindowsOS, flickering of composited images can be improved considerably by slowing the refresh rate of the window. The optimal refresh rate may depend on the number of composited bitmaps.minTime is the minimum refresh delay, in seconds, when only one bitmap is composited onto the window. The delay time will increase linearly with the number of bitmaps, up to a maximum of maxTime when numBitmapsWhenMax is reached.If both minTime and maxTime are 0, all delay settings for the window are cleared.Returns:
---* retval = 1 if successful, 0 if arguments are invalid (i.e. if maxTime < minTime, or maxBitmaps < 1).
---* If delay times have not previously been set for this window, prev time values are 0.
---@param windowHWND identifier
---@param minTime number
---@param maxTime number
---@param numBitmapsWhenMax integer
---@return integer retval, number prevMinTime, number prevMaxTime, integer prevBitmaps
function reaper.JS_Composite_Delay(windowHWND, minTime, maxTime, numBitmapsWhenMax) end

---Returns all bitmaps composited to the given window.The list is formatted as a comma-separated string of hexadecimal values, each representing a LICE_IBitmap\* pointer.retval is the number of linked bitmaps found, or negative if an error occured.
---
---@param windowHWND identifier
---@return integer retval, string list
function reaper.JS_Composite_ListBitmaps(windowHWND) end

---Unlinks the window and bitmap.* autoUpdate is an optional parameter. If unlinking a single bitmap and autoUpdate is true, the function will automatically re-draw the window to remove the blitted image.If no bitmap is specified, all bitmaps composited to the window will be unlinked -- even those by other scripts.
---@param windowHWND identifier
---@param bitmap identifier
---@param autoUpdate boolean
function reaper.JS_Composite_Unlink(windowHWND, bitmap, autoUpdate) end

---Returns the 8-byte floating point value at address[offset]. Offset is added as steps of 8 bytes each.
---@param address identifier
---@param pointer integer
---@return number double
function reaper.JS_Double(address, pointer) end

---Returns information about a file.cTime is not implemented on all systems. If it does return a time, the value may differ depending on the OS: on WindowsOS, it may refer to the time that the file was either created or copied, whereas on Linux and macOS, it may refer to the time of last status change.retval is 0 if successful, negative if not.
---@param filePath string
---@return integer retval, number size, string accessedTime, string modifiedTime, string cTime, integer deviceID, integer deviceSpecialID, integer inode, integer mode, integer numLinks, integer ownerUserID, integer ownerGroupID
function reaper.JS_File_Stat(filePath) end

---Blits between two device contexts, which may include LICE "system bitmaps".mode: Optional parameter. "SRCCOPY" by default, or specify "ALPHA" to enable per-pixel alpha blending.WARNING: On WindowsOS, GDI\_Blit does not perform alpha multiplication of the source bitmap. For proper color rendering, a separate pre-multiplication step is therefore required, using either LICE\_Blit or LICE\_ProcessRect.
---@param destHDC identifier
---@param dstx integer
---@param dsty integer
---@param sourceHDC identifier
---@param srcx integer
---@param srxy integer
---@param width integer
---@param height integer
---@param mode? string
function reaper.JS_GDI_Blit(destHDC, dstx, dsty, sourceHDC, srcx, srxy, width, height, mode) end

---@param color integer
---@return identifier font
function reaper.JS_GDI_CreateFillBrush(color) end

---Parameters:* weight: 0 - 1000, with 0 = auto, 400 = normal and 700 = bold.* angle: the angle, in tenths of degrees, between the text and the x-axis of the device.* fontName: If empty string "", uses first font that matches the other specified attributes.           Note: Text color must be set separately.
---
---@param height integer
---@param weight integer
---@param angle integer
---@param italic boolean
---@param underline boolean
---@param strike boolean
---@param fontName string
---@return identifier font
function reaper.JS_GDI_CreateFont(height, weight, angle, italic, underline, strike, fontName) end

---@param width integer
---@param color integer
---@return identifier pen
function reaper.JS_GDI_CreatePen(width, color) end

---@param GDIObject identifier
function reaper.JS_GDI_DeleteObject(GDIObject) end

---Parameters:* align: Combination of: "TOP", "VCENTER", "LEFT", "HCENTER", "RIGHT", "BOTTOM", "WORDBREAK", "SINGLELINE", "NOCLIP", "CALCRECT", "NOPREFIX" or "ELLIPSIS"
---
---@param deviceHDC identifier
---@param text string
---@param len integer
---@param left integer
---@param top integer
---@param right integer
---@param bottom integer
---@param align string
---@return integer retval
function reaper.JS_GDI_DrawText(deviceHDC, text, len, left, top, right, bottom, align) end

---@param deviceHDC identifier
---@param left integer
---@param top integer
---@param right integer
---@param bottom integer
function reaper.JS_GDI_FillEllipse(deviceHDC, left, top, right, bottom) end

---packedX and packedY are strings of points, each packed as "<i4".
---
---@param deviceHDC identifier
---@param packedX string
---@param packedY string
---@param numPoints integer
function reaper.JS_GDI_FillPolygon(deviceHDC, packedX, packedY, numPoints) end

---@param deviceHDC identifier
---@param left integer
---@param top integer
---@param right integer
---@param bottom integer
function reaper.JS_GDI_FillRect(deviceHDC, left, top, right, bottom) end

---@param deviceHDC identifier
---@param left integer
---@param top integer
---@param right integer
---@param bottom integer
---@param xrnd integer
---@param yrnd integer
function reaper.JS_GDI_FillRoundRect(deviceHDC, left, top, right, bottom, xrnd, yrnd) end

---Returns the device context for the client area of the specified window.
---
---@param windowHWND identifier
---@return identifier device_context
function reaper.JS_GDI_GetClientDC(windowHWND) end

---Returns a device context for the entire screen.WARNING: Only available on Windows, not Linux or MacOS.
---
---@return identifier device_context
function reaper.JS_GDI_GetScreenDC() end

---@param GUIElement string
---@return integer retval
function reaper.JS_GDI_GetSysColor(GUIElement) end

---@param deviceHDC identifier
---@return integer retval
function reaper.JS_GDI_GetTextColor(deviceHDC) end

---Returns the device context for the entire window, including title bar and frame.
---
---@param windowHWND identifier
---@return identifier device_context
function reaper.JS_GDI_GetWindowDC(windowHWND) end

---@param deviceHDC identifier
---@param x1 integer
---@param y1 integer
---@param x2 integer
---@param y2 integer
function reaper.JS_GDI_Line(deviceHDC, x1, y1, x2, y2) end

---packedX and packedY are strings of points, each packed as "<i4".
---
---@param deviceHDC identifier
---@param packedX string
---@param packedY string
---@param numPoints integer
function reaper.JS_GDI_Polyline(deviceHDC, packedX, packedY, numPoints) end

---To release a window HDC, both arguments must be supplied: the HWND as well as the HDC. To release a screen DC, only the HDC needs to be supplied.For compatibility with previous versions, the HWND and HDC can be supplied in any order.NOTE: Any GDI HDC should be released immediately after drawing, and deferred scripts should get and release new DCs in each cycle.
---@param windowHWND identifier
---@param deviceHDC identifier
function reaper.JS_GDI_ReleaseDC(windowHWND, deviceHDC) end

---Activates a font, pen, or fill brush for subsequent drawing in the specified device context.
---
---@param deviceHDC identifier
---@param GDIObject identifier
---@return identifier object
function reaper.JS_GDI_SelectObject(deviceHDC, GDIObject) end

---@param deviceHDC identifier
---@param x integer
---@param y integer
---@param color integer
function reaper.JS_GDI_SetPixel(deviceHDC, x, y, color) end

---@param deviceHDC identifier
---@param color integer
function reaper.JS_GDI_SetTextBkColor(deviceHDC, color) end

---@param deviceHDC identifier
---@param mode integer
function reaper.JS_GDI_SetTextBkMode(deviceHDC, mode) end

---@param deviceHDC identifier
---@param color integer
function reaper.JS_GDI_SetTextColor(deviceHDC, color) end

---Blits between two device contexts, which may include LICE "system bitmaps".modeOptional: "SRCCOPY" by default, or specify "ALPHA" to enable per-pixel alpha blending.WARNING: On WindowsOS, GDI\_Blit does not perform alpha multiplication of the source bitmap. For proper color rendering, a separate pre-multiplication step is therefore required, using either LICE\_Blit or LICE\_ProcessRect.
---@param destHDC identifier
---@param dstx integer
---@param dsty integer
---@param dstw integer
---@param dsth integer
---@param sourceHDC identifier
---@param srcx integer
---@param srxy integer
---@param srcw integer
---@param srch integer
---@param mode? string
function reaper.JS_GDI_StretchBlit(destHDC, dstx, dsty, dstw, dsth, sourceHDC, srcx, srxy, srcw, srch, mode) end

---returns the number of item of the listview
---@param headerHWND identifier
---@return integer count
function reaper.JS_Header_GetItemCount(headerHWND) end

---Returns the 4-byte signed integer at address[offset]. Offset is added as steps of 4 bytes each.
---@param pointer identifier
---@param offset integer
---@return integer int
function reaper.JS_Int(pointer, offset) end

---Hue is rolled over, saturation and value are clamped, all 0..1. (Alpha remains unchanged.)
---@param bitmap identifier
---@param hue number
---@param saturation number
---@param value number
function reaper.JS_LICE_AlterBitmapHSV(bitmap, hue, saturation, value) end

---Hue is rolled over, saturation and value are clamped, all 0..1. (Alpha remains unchanged.)
---@param bitmap identifier
---@param x integer
---@param y integer
---@param w integer
---@param h integer
---@param hue number
---@param saturation number
---@param value number
function reaper.JS_LICE_AlterRectHSV(bitmap, x, y, w, h, hue, saturation, value) end

---LICE modes: "COPY" (default if empty string), "MASK", "ADD", "DODGE", "MUL", "OVERLAY" or "HSVADJ", any of which may be combined with "ALPHA".LICE color format: 0xAARRGGBB (AA is only used in ALPHA mode).
---@param bitmap identifier
---@param cx number
---@param cy number
---@param r number
---@param minAngle number
---@param maxAngle number
---@param color integer
---@param alpha number
---@param mode string
---@param antialias boolean
function reaper.JS_LICE_Arc(bitmap, cx, cy, r, minAngle, maxAngle, color, alpha, mode, antialias) end

---@param reaperarray identifier
---@return integer retval
function reaper.JS_LICE_ArrayAllBitmaps(reaperarray) end

---LICE modes: "COPY" (default if empty string), "MASK", "ADD", "DODGE", "MUL", "OVERLAY" or "HSVADJ", any of which may be combined with "ALPHA" to enable per-pixel alpha blending.LICE color format: 0xAARRGGBB (AA is only used in ALPHA mode).
---@param bitmap identifier
---@param xstart number
---@param ystart number
---@param xctl1 number
---@param yctl1 number
---@param xctl2 number
---@param yctl2 number
---@param xend number
---@param yend number
---@param tol number
---@param color integer
---@param alpha number
---@param mode string
---@param antialias boolean
function reaper.JS_LICE_Bezier(bitmap, xstart, ystart, xctl1, yctl1, xctl2, yctl2, xend, yend, tol, color, alpha, mode, antialias) end

---Standard LICE modes: "COPY" (default if empty string), "MASK", "ADD", "DODGE", "MUL", "OVERLAY" or "HSVADJ", any of which may be combined with "ALPHA" to enable per-pixel alpha blending.In addition to the standard LICE modes, LICE\_Blit also offers:
---\* "CHANCOPY\_XTOY", with X and Y any of the four channels, A, R, G or B. (CHANCOPY\_ATOA is similar to MASK mode.)
---\* "BLUR"
---\* "ALPHAMUL", which overwrites the destination with a per-pixel alpha-multiplied copy of the source. (Similar to first clearing the destination with 0x00000000 and then blitting with "COPY,ALPHA".)
---@param destBitmap identifier
---@param dstx integer
---@param dsty integer
---@param sourceBitmap identifier
---@param srcx integer
---@param srcy integer
---@param width integer
---@param height integer
---@param alpha number
---@param mode string
function reaper.JS_LICE_Blit(destBitmap, dstx, dsty, sourceBitmap, srcx, srcy, width, height, alpha, mode) end

---LICE modes: "COPY" (default if empty string), "MASK", "ADD", "DODGE", "MUL", "OVERLAY" or "HSVADJ", any of which may be combined with "ALPHA".
---LICE color format: 0xAARRGGBB (AA is only used in ALPHA mode).
---
---@param bitmap identifier
---@param cx number
---@param cy number
---@param r number
---@param color integer
---@param alpha number
---@param mode string
---@param antialias boolean
function reaper.JS_LICE_Circle(bitmap, cx, cy, r, color, alpha, mode, antialias) end

---@param bitmap identifier
---@param color integer
function reaper.JS_LICE_Clear(bitmap, color) end

---@param isSysBitmap boolean
---@param width integer
---@param height integer
---@return identifier bitmap
function reaper.JS_LICE_CreateBitmap(isSysBitmap, width, height) end

---@return identifier font
function reaper.JS_LICE_CreateFont() end

---Deletes the bitmap, and also unlinks bitmap from any composited window.
---@param bitmap identifier
function reaper.JS_LICE_DestroyBitmap(bitmap) end

---@param LICEFont identifier
function reaper.JS_LICE_DestroyFont(LICEFont) end

---@param bitmap identifier
---@param x integer
---@param y integer
---@param c integer
---@param color integer
---@param alpha number
---@param mode integer
function reaper.JS_LICE_DrawChar(bitmap, x, y, c, color, alpha, mode) end

---@param bitmap identifier
---@param LICEFont identifier
---@param text string
---@param textLen integer
---@param x1 integer
---@param y1 integer
---@param x2 integer
---@param y2 integer
---@return integer retval
function reaper.JS_LICE_DrawText(bitmap, LICEFont, text, textLen, x1, y1, x2, y2) end

---LICE modes: "COPY" (default if empty string), "MASK", "ADD", "DODGE", "MUL", "OVERLAY" or "HSVADJ", any of which may be combined with "ALPHA".LICE color format: 0xAARRGGBB (AA is only used in ALPHA mode).
---
---@param bitmap identifier
---@param cx number
---@param cy number
---@param r number
---@param color integer
---@param alpha number
---@param mode string
---@param antialias boolean
function reaper.JS_LICE_FillCircle(bitmap, cx, cy, r, color, alpha, mode, antialias) end

---packedX and packedY are two strings of coordinates, each packed as "<i4".LICE modes : "COPY" (default if empty string), "MASK", "ADD", "DODGE", "MUL", "OVERLAY" or "HSVADJ", any of which may be combined with "ALPHA" to enable per-pixel alpha blending.LICE color format: 0xAARRGGBB (AA is only used in ALPHA mode).
---@param bitmap identifier
---@param packedX string
---@param packedY string
---@param numPoints integer
---@param color integer
---@param alpha number
---@param mode string
function reaper.JS_LICE_FillPolygon(bitmap, packedX, packedY, numPoints, color, alpha, mode) end

---LICE modes: "COPY" (default if empty string), "MASK", "ADD", "DODGE", "MUL", "OVERLAY" or "HSVADJ", any of which may be combined with "ALPHA".LICE color format: 0xAARRGGBB (AA is only used in ALPHA mode).
---@param bitmap identifier
---@param x integer
---@param y integer
---@param w integer
---@param h integer
---@param color integer
---@param alpha number
---@param mode string
function reaper.JS_LICE_FillRect(bitmap, x, y, w, h, color, alpha, mode) end

---LICE modes: "COPY" (default if empty string), "MASK", "ADD", "DODGE", "MUL", "OVERLAY" or "HSVADJ", any of which may be combined with "ALPHA".LICE color format: 0xAARRGGBB (AA is only used in ALPHA mode).
---@param bitmap identifier
---@param x1 integer
---@param y1 integer
---@param x2 integer
---@param y2 integer
---@param x3 integer
---@param y3 integer
---@param color integer
---@param alpha number
---@param mode string
function reaper.JS_LICE_FillTriangle(bitmap, x1, y1, x2, y2, x3, y3, color, alpha, mode) end

---@param bitmap identifier
---@return identifier device_context
function reaper.JS_LICE_GetDC(bitmap) end

---@param bitmap identifier
---@return integer retval
function reaper.JS_LICE_GetHeight(bitmap) end

---Returns the color of the specified pixel.
---
---@param bitmap identifier
---@param x integer
---@param y integer
---@return integer retval
function reaper.JS_LICE_GetPixel(bitmap, x, y) end

---@param bitmap identifier
---@return integer retval
function reaper.JS_LICE_GetWidth(bitmap) end

---@param bitmap identifier
---@param dstx integer
---@param dsty integer
---@param dstw integer
---@param dsth integer
---@param ir number
---@param ig number
---@param ib number
---@param ia number
---@param drdx number
---@param dgdx number
---@param dbdx number
---@param dadx number
---@param drdy number
---@param dgdy number
---@param dbdy number
---@param dady number
---@param mode string
function reaper.JS_LICE_GradRect(bitmap, dstx, dsty, dstw, dsth, ir, ig, ib, ia, drdx, dgdx, dbdx, dadx, drdy, dgdy, dbdy, dady, mode) end

---@param bitmap identifier
---@return boolean retval
function reaper.JS_LICE_IsFlipped(bitmap) end

---LICE modes: "COPY" (default if empty string), "MASK", "ADD", "DODGE", "MUL", "OVERLAY" or "HSVADJ", any of which may be combined with "ALPHA".LICE color format: 0xAARRGGBB (AA is only used in ALPHA mode).
---@param bitmap identifier
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param color integer
---@param alpha number
---@param mode string
---@param antialias boolean
function reaper.JS_LICE_Line(bitmap, x1, y1, x2, y2, color, alpha, mode, antialias) end

---@return integer retval, string list
function reaper.JS_LICE_ListAllBitmaps() end

---Returns a system LICE bitmap containing the JPEG.
---@param filename string
---@return identifier image
function reaper.JS_LICE_LoadJPG(filename) end

---Returns a system LICE bitmap containing the JPEG.
---@param buffer string
---@param bufsize integer
---@return identifier image
function reaper.JS_LICE_LoadJPGFromMemory(buffer, bufsize) end

---Returns a system LICE bitmap containing the PNG.
---
---@param filename string
---@return identifier bitmap
function reaper.JS_LICE_LoadPNG(filename) end

---Returns a system LICE bitmap containing the PNG.
---@param buffer string
---@param bufsize integer
---@return identifier bitmap
function reaper.JS_LICE_LoadPNGFromMemory(buffer, bufsize) end

---@param text string
---@return integer width, integer Height
function reaper.JS_LICE_MeasureText(text) end

---Applies bitwise operations to each pixel in the target rectangle.operand: a color in 0xAARRGGBB format.modes:
---\* "XOR", "OR" or "AND".
---\* "SET\_XYZ", with XYZ any combination of A, R, G, and B: copies the specified channels from operand to the bitmap. (Useful for setting the alpha values of a bitmap.)
---\* "ALPHAMUL": Performs alpha pre-multiplication on each pixel in the rect. operand is ignored in this mode. (On WindowsOS, GDI\_Blit does not perform alpha multiplication on the fly, and a separate alpha pre-multiplication step is therefore required.)NOTE:
---LICE\_Blit and LICE\_ScaledBlit are also useful for processing bitmap colors. For example, to multiply all channel values by 1.5:
---reaper.JS\_LICE\_Blit(bitmap, x, y, bitmap, x, y, w, h, 0.5, "ADD").
---@param bitmap identifier
---@param x integer
---@param y integer
---@param w integer
---@param h integer
---@param mode string
---@param operand number
---@return boolean retval
function reaper.JS_LICE_ProcessRect(bitmap, x, y, w, h, mode, operand) end

---LICE modes: "COPY" (default if empty string), "MASK", "ADD", "DODGE", "MUL", "OVERLAY" or "HSVADJ", any of which may be combined with "ALPHA".LICE color format: 0xAARRGGBB (AA is only used in ALPHA mode).
---@param bitmap identifier
---@param x integer
---@param y integer
---@param color integer
---@param alpha number
---@param mode string
function reaper.JS_LICE_PutPixel(bitmap, x, y, color, alpha, mode) end

---@param bitmap identifier
---@param width integer
---@param height integer
function reaper.JS_LICE_Resize(bitmap, width, height) end

---LICE modes: "COPY" (default if empty string), "MASK", "ADD", "DODGE", "MUL", "OVERLAY" or "HSVADJ", any of which may be combined with "ALPHA" to enable per-pixel alpha blending.
---@param destBitmap identifier
---@param dstx integer
---@param dsty integer
---@param dstw integer
---@param dsth integer
---@param sourceBitmap identifier
---@param srcx number
---@param srcy number
---@param srcw number
---@param srch number
---@param angle number
---@param rotxcent number
---@param rotycent number
---@param cliptosourcerect boolean
---@param alpha number
---@param mode string
function reaper.JS_LICE_RotatedBlit(destBitmap, dstx, dsty, dstw, dsth, sourceBitmap, srcx, srcy, srcw, srch, angle, rotxcent, rotycent, cliptosourcerect, alpha, mode) end

---LICE modes: "COPY" (default if empty string), "MASK", "ADD", "DODGE", "MUL", "OVERLAY" or "HSVADJ", any of which may be combined with "ALPHA".LICE color format: 0xAARRGGBB (AA is only used in ALPHA mode).
---
---@param bitmap identifier
---@param x number
---@param y number
---@param w number
---@param h number
---@param cornerradius integer
---@param color integer
---@param alpha number
---@param mode string
---@param antialias boolean
function reaper.JS_LICE_RoundRect(bitmap, x, y, w, h, cornerradius, color, alpha, mode, antialias) end

---LICE modes: "COPY" (default if empty string), "MASK", "ADD", "DODGE", "MUL", "OVERLAY" or "HSVADJ", any of which may be combined with "ALPHA" to enable per-pixel alpha blending.
---@param destBitmap identifier
---@param dstx integer
---@param dsty integer
---@param dstw integer
---@param dsth integer
---@param srcBitmap identifier
---@param srcx number
---@param srcy number
---@param srcw number
---@param srch number
---@param alpha number
---@param mode string
function reaper.JS_LICE_ScaledBlit(destBitmap, dstx, dsty, dstw, dsth, srcBitmap, srcx, srcy, srcw, srch, alpha, mode) end

---Sets all pixels that match the given color's RGB values to fully transparent, and all other pixels to fully opaque. (All pixels' RGB values remain unchanged.)
---@param bitmap identifier
---@param colorRGB integer
function reaper.JS_LICE_SetAlphaFromColorMask(bitmap, colorRGB) end

---Sets the color of the font background.
---@param LICEFont identifier
---@param color integer
function reaper.JS_LICE_SetFontBkColor(LICEFont, color) end

---@param LICEFont identifier
---@param color integer
function reaper.JS_LICE_SetFontColor(LICEFont, color) end

---Sets the color of font FX such as shadow.
---@param LICEFont identifier
---@param color integer
function reaper.JS_LICE_SetFontFXColor(LICEFont, color) end

---Converts a GDI font into a LICE font.The font can be modified by the following flags, in a comma-separated list:"VERTICAL", "BOTTOMUP", "NATIVE", "BLUR", "INVERT", "MONO", "SHADOW" or "OUTLINE".
---@param LICEFont identifier
---@param GDIFont identifier
---@param moreFormats string
function reaper.JS_LICE_SetFontFromGDI(LICEFont, GDIFont, moreFormats) end

---Parameters:\* quality is an integer in the range 1..100.
---\* forceBaseline is an optional boolean parameter that ensures compatibility with all JPEG viewers by preventing too low quality, "cubist" settings. 
---@param filename string
---@param bitmap identifier
---@param quality integer
---@param forceBaseline unsupported
---@return boolean 
function reaper.JS_LICE_WriteJPG(filename, bitmap, quality, forceBaseline) end

---Writes the contents of a LICE_IBitMap as png-file.
---@param filename string
---@param bitmap identifier
---@param wantAlpha boolean
---@return boolean 
function reaper.JS_LICE_WritePNG(filename, bitmap, wantAlpha) end

---@param listviewHWND identifier
---@param index integer
---@param partialOK boolean
function reaper.JS_ListView_EnsureVisible(listviewHWND, index, partialOK) end

---Returns the translation of the given US English text, according to the currently loaded Language Pack.Parameters:
---\* LangPackSection: Language Packs are divided into sections such as "common" or "DLG\_102".
---\* In Lua, by default, text of up to 1024 chars can be returned. To increase (or reduce) the default buffer size, a string and size can be included as optional 3rd and 4th arguments.Example: reaper.JS\_Localize("Actions", "common", "", 20)
---@param USEnglish string
---@param LangPackSection string
---@return string translation
function reaper.JS_Localize(USEnglish, LangPackSection) end

---Returns the addresses of all open MIDI windows (whether docked or not).\* The addresses are stored in the provided reaper.array.\* Each address can be converted to a REAPER object (HWND) by the function JS\_Window\_HandleFromAddress.
---
---@param reaperarray identifier
function reaper.JS_MIDIEditor_ArrayAll(reaperarray) end

---Returns a list of HWNDs of all open MIDI windows (whether docked or not).\* The list is formatted as a comma-separated (and terminated) string of hexadecimal values.\* Each value is an address that can be converted to a HWND by the function JS\_Window\_HandleFromAddress.
---
---@param buf string
---@return string buf
function reaper.JS_MIDIEditor_ListAll(buf) end

---Allocates memory for general use by functions that require memory buffers.
---@param sizeBytes integer
---@return identifier memory
function reaper.JS_Mem_Alloc(sizeBytes) end

---Frees memory that was previously allocated by JS\_Mem\_Alloc.
---@param mallocPointer identifier
---@return boolean retval
function reaper.JS_Mem_Free(mallocPointer) end

---Copies a packed string into a memory buffer.
---@param mallocPointer identifier
---@param offset integer
---@param packedString string
---@param stringLength integer
---@return boolean retval
function reaper.JS_Mem_FromString(mallocPointer, offset, packedString, stringLength) end

---On Windows, retrieves a handle to the current mouse cursor.
---On Linux and macOS, retrieves a handle to the last cursor set by REAPER or its extensions via SWELL.
---@return identifier mouse_cursor
function reaper.JS_Mouse_GetCursor() end

---Retrieves the states of mouse buttons and modifiers keys.Parameters:* flags, state: The parameter and the return value both use the same format as gfx.mouse_cap. I.e., to get the states of the left mouse button and the ctrl key, use flags = 0b00000101.
---use -1 as flags to retrieve the states of all mouse-buttons and modifier
---@param flags integer
---@return integer mouse_states
function reaper.JS_Mouse_GetState(flags) end

---Loads a cursor by number.cursorNumber: Same as used for gfx.setcursor, and includes some of Windows' predefined cursors (with numbers > 32000; refer to documentation for the Win32 C++ function LoadCursor), and REAPER's own cursors (with numbers < 2000). If successful, returns a handle to the cursor, which can be used in [JS\_Mouse\_SetCursor](#JS_Mouse_SetCursor).
---
---@param cursorNumber integer
---@return identifier mouse_cursor
function reaper.JS_Mouse_LoadCursor(cursorNumber) end

---Loads a cursor from a .cur file.forceNewLoad is an optional boolean parameter:
---* If omitted or false, and if the cursor file has already been loaded previously during the REAPER session by any script, the file will not be re-loaded, and the existing handle will be returned.
---* If true, the file will be re-loaded and a new handle will be returned.
---* WARNING: Each time that a cursor file is re-loaded, the number of GDI objects increases for the entire duration of the REAPER session.If successful, returns a handle to the cursor, which can be used in JS_Mouse_SetCursor.
---@param pathAndFileName string
---@param forceNewLoad? boolean
---@return identifier mouse_cursor
function reaper.JS_Mouse_LoadCursorFromFile(pathAndFileName, forceNewLoad) end

---Sets the mouse cursor.  (Only lasts while script is running, and for a single "defer" cycle.)
---
---@param cursorHandle identifier
function reaper.JS_Mouse_SetCursor(cursorHandle) end

---Moves the mouse cursor to the specified coordinates.
---
---@param x integer
---@param y integer
---@return boolean retval
function reaper.JS_Mouse_SetPosition(x, y) end

---@param s string
---@return identifier ptr
function reaper.JS_PtrFromStr(s) end

---Returns the version of the js_ReaScriptAPI extension.
---
---@return number version
function reaper.JS_ReaScriptAPI_Version() end

---Returns the memory contents starting at address[offset] as a packed string. Offset is added as steps of 1 byte (char) each.
---@param pointer identifier
---@param offset integer
---@param lengthChars integer
---@return boolean retval, string buf
function reaper.JS_String(pointer, offset, lengthChars) end

---Returns a 255-byte array that specifies which virtual keys, from 0x01 to 0xFF, have sent KEYDOWN messages since cutoffTime.Notes:
---* Mouse buttons and modifier keys are not (currently) reliably detected, and JS\_Mouse\_GetState can be used instead.
---* Auto-repeated KEYDOWN messages are ignored.
---@param cutoffTime number
---@return string state
function reaper.JS_VKeys_GetDown(cutoffTime) end

---deprecated
function reaper.JS_VKeys_ClearHistory() end

---deprecated
---@return boolean retval, string state
function reaper.JS_VKeys_GetHistory() end

---Retrieves the current states (0 or 1) of all virtual keys, from 0x01 to 0xFF, in a 255-byte array.cutoffTime: A key is only regarded as down if it sent a KEYDOWN message after the cut-off time, not followed by KEYUP. (This is useful for excluding old KEYDOWN messages that weren't properly followed by KEYUP.) 
---If cutoffTime is positive, is it interpreted as absolute time in similar format as time_precise().
---If cutoffTime is negative, it is relative to the current time.Notes:
---Notes:
---* Mouse buttons and modifier keys are not (currently) reliably detected, and JS\_Mouse\_GetState can be used instead.
---* Auto-repeated KEYDOWN messages are ignored.
---@param cutoffTime number
---@return string state, integer unknown
function reaper.JS_VKeys_GetState(cutoffTime) end

---Return a 255-byte array that specifies which virtual keys, from 0x01 to 0xFF, have sent KEYUP messages since cutoffTime.Note: Mouse buttons and modifier keys are not (currently) reliably detected, and [JS\_Mouse\_GetState](#JS_Mouse_GetState) can be used instead.
---@param cutoffTime number
---@return string state
function reaper.JS_VKeys_GetUp(cutoffTime) end

---Intercepting (blocking) virtual keys work similar to the native function PreventUIRefresh: Each key has a (non-negative) intercept state, and the key is passed through as usual if the state equals 0, or blocked if the state is greater than 0.keyCode: The virtual key code of the key, or -1 to change the state of all keys.intercept: A script can increase the intercept state by passing +1, or lower the state by passing -1. 
---Multiple scripts can block the same key, and the intercept state may reach up to 255. 
---If zero is passed, the intercept state is not changed, but the current state is returned.Returns: If keyCode refers to a single key, the intercept state of that key is returned. If keyCode = -1, the state of the key that is most strongly blocked (highest intercept state) is returned.
---@param keyCode integer
---@param intercept integer
---@return integer retval
function reaper.JS_VKeys_Intercept(keyCode, intercept) end

---Intercepts window messages to specified window.Parameters: * message: a single message type to be intercepted, either in WM_ or hexadecimal format. For example "WM_SETCURSOR" or "0x0020". * passThrough: Whether message should be blocked (false) or passed through (true) to the window.    For more information on message codes, refer to the Win32 C++ API documentation.    For a list of message types that are valid cross-platform, refer to swell-types.h. Only these will be recognized by WM_ name.Returns: * 1: Success. * 0: The message type is already being intercepted by another script. * -2: message string could not be parsed. * -3: Failure getting original window process / window not valid. * -6: Could not obtain the window client HDC.
---Notes: * Intercepted messages can be polled using JS_WindowMessage_Peek. * Intercepted messages can be edited, if necessary, and then forwarded to their original destination using JS_WindowMessage_Post or JS_WindowMessage_Send. * To check whether a message type is being blocked or passed through, Peek the message type, or retrieve the entire List of intercepts. * Mouse events are typically received by the child window under the mouse, not the parent window. Keyboard events are usually *not* received by any individual window. To intercept keyboard events, use the VKey functions.
---@param windowHWND identifier
---@param messages string
---@param passThrough boolean
---@return integer retval
function reaper.JS_WindowMessage_Intercept(windowHWND, messages, passThrough) end

---Intercepts window messages to specified window.           Parameters:* messages: comma-separated string of message types to be intercepted (either in WM_ or hexadecimal format), each with a "block" or "passthrough" modifier to specify whether the message should be blocked or passed through to the window. For example "WM_SETCURSOR:block, 0x0201:passthrough".   For more information on message codes, refer to the Win32 C++ API documentation.   For a list of message types that are valid cross-platform, refer to swell-types.h. Only these will be recognized by WM_ name.           Returns:* 1: Success.* 0: The message type is already being intercepted by another script.* -1: windowHWND is not a valid window.* -2: message string could not be parsed.* -3: Failure getting original window process.* -6: Could not obtain the window client HDC.           Notes:* Intercepted messages can be polled using JS_WindowMessage_Peek.* Intercepted messages can be edited, if necessary, and then forwarded to their original destination using JS_WindowMessage_Post or JS_WindowMessage_Send.* To check whether a message type is being blocked or passed through, Peek the message type, or retrieve the entire List of intercepts.
---
---@param windowHWND identifier
---@param messages string
---@return integer retval
function reaper.JS_WindowMessage_InterceptList(windowHWND, messages) end

---Returns a string with a list of all message types currently being intercepted for the specified window.
---
---@param windowHWND identifier
---@param buf string
---@return boolean retval, string buf
function reaper.JS_WindowMessage_ListIntercepts(windowHWND, buf) end

---Changes the passthrough setting of a message type that is already being intercepted.Returns 1 if successful, 0 if the message type is not yet being intercepted, or -2 if the argument could not be parsed.
---@param windowHWND identifier
---@param message string
---@param passThrough boolean
---@return integer retval
function reaper.JS_WindowMessage_PassThrough(windowHWND, message, passThrough) end

---Polls the state of an intercepted message.           Parameters:* message: String containing a single message name, such as "WM_SETCURSOR", or in hexadecimal format, "0x0020".(For a list of message types that are valid cross-platform, refer to swell-types.h. Only these will be recognized by WM_ name.)           Returns:* A retval of false indicates that the message type is not being intercepted in the specified window.* All messages are timestamped. A time of 0 indicates that no message if this type has been intercepted yet.* For more information about wParam and lParam for different message types, refer to Win32 C++ documentation.* For example, in the case of mousewheel, returns mousewheel delta, modifier keys, x position and y position.* wParamHigh, lParamLow and lParamHigh are signed, whereas wParamLow is unsigned.
---
---@param windowHWND identifier
---@param message string
---@return boolean retval, boolean passedThrough, number time, integer wParamLow, integer wParamHigh, integer lParamLow, integer lParamHigh
function reaper.JS_WindowMessage_Peek(windowHWND, message) end

---If the specified window and message type are not currently being intercepted by a script, this function will post the message in the message queue of the specified window, and return without waiting.If the window and message type are currently being intercepted, the message will be sent directly to the original window process, similar to WindowMessage_Send, thereby skipping any intercepts.Parameters:
---* message: String containing a single message name, such as "WM_SETCURSOR", or in hexadecimal format, "0x0020".
---(For a list of WM_ and CB_ message types that are valid cross-platform, refer to swell-types.h. Only these will be recognized by WM_ or CB_ name.)
---* wParam, wParamHigh, lParam and lParamHigh: Low and high 16-bit WORDs of the WPARAM and LPARAM parameters.
---(Most window messages encode separate information into the two WORDs. However, for those rare cases in which the entire WPARAM and LPARAM must be used to post a large pointer, the script can store this address in wParam or lParam, and keep wParamHigh and lParamHigh zero.)Notes:
---* For more information about parameter values, refer to documentation for the Win32 C++ function PostMessage.
---* Messages should only be sent to windows that were created from the main thread.
---* Useful for simulating mouse clicks and calling mouse modifier actions from scripts.
---@param windowHWND identifier
---@param message string
---@param wParam number
---@param wParamHighWord integer
---@param lParam number
---@param lParamHighWord integer
---@return boolean retval
function reaper.JS_WindowMessage_Post(windowHWND, message, wParam, wParamHighWord, lParam, lParamHighWord) end

---Release intercepts of specified message types.           Parameters:* messages: "WM_SETCURSOR,WM_MOUSEHWHEEL" or "0x0020,0x020E", for example.
---
---@param windowHWND identifier
---@param messages string
---@return integer retval
function reaper.JS_WindowMessage_Release(windowHWND, messages) end

---Release script intercepts of window messages for all windows.
---
function reaper.JS_WindowMessage_ReleaseAll() end

---Release script intercepts of window messages for specified window.
---
---@param windowHWND identifier
function reaper.JS_WindowMessage_ReleaseWindow(windowHWND) end

---Sends a message to the specified window by calling the window process directly, and only returns after the message has been processed. Any intercepts of the message by scripts will be skipped, and the message can therefore not be blocked.Parameters:
---* message: String containing a single message name, such as "WM_SETCURSOR", or in hexadecimal format, "0x0020".
---(For a list of WM_ and CB_ message types that are valid cross-platform, refer to swell-types.h. Only these will be recognized by WM_ or CB_ name.)
---* wParam, wParamHigh, lParam and lParamHigh: Low and high 16-bit WORDs of the WPARAM and LPARAM parameters.
---(Most window messages encode separate information into the two WORDs. However, for those rare cases in which the entire WPARAM and LPARAM must be used to post a large pointer, the script can store this address in wParam or lParam, and keep wParamHigh and lParamHigh zero.)Notes:
---* For more information about parameter and return values, refer to documentation for the Win32 C++ function SendMessage.
---* Messages should only be sent to windows that were created from the main thread.
---* Useful for simulating mouse clicks and calling mouse modifier actions from scripts.
---@param windowHWND identifier
---@param message string
---@param wParam number
---@param wParamHighWord integer
---@param lParam number
---@param lParamHighWord integer
---@return integer retval
function reaper.JS_WindowMessage_Send(windowHWND, message, wParam, wParamHighWord, lParam, lParamHighWord) end

---@param handle identifier
---@return number address
function reaper.JS_Window_AddressFromHandle(handle) end

---Returns all child windows of the specified parent.           The addresses are stored in the provided reaper.array, and can be converted to REAPER objects (HWNDs) by the function JS_Window_HandleFromAddress.
---
---@param parentHWND identifier
---@param reaperarray identifier
function reaper.JS_Window_ArrayAllChild(parentHWND, reaperarray) end

---Returns all top-level windows.           The addresses are stored in the provided reaper.array, and can be converted to REAPER objects (HWNDs) by the function JS_Window_HandleFromAddress.
---
---@param reaperarray identifier
function reaper.JS_Window_ArrayAllTop(reaperarray) end

---Returns all windows, whether top-level or child, whose titles match the specified string.           The addresses are stored in the provided reaper.array, and can be converted to REAPER objects (HWNDs) by the function JS_Window_HandleFromAddress.           Parameters: * exact: Match entire title exactly, or match substring of title.
---
---@param title string
---@param exact boolean
---@param reaperarray identifier
function reaper.JS_Window_ArrayFind(title, exact, reaperarray) end

---@param windowHWND identifier
function reaper.JS_Window_AttachResizeGrip(windowHWND) end

---Attaches a "pin on top" button to the window frame. The button should remember its state when closing and re-opening the window.WARNING: This function does not yet work on Linux.
---@param windowHWND identifier
---@return identifier HWND
function reaper.JS_Window_AttachTopmostPin(windowHWND) end

---Converts the client-area coordinates of a specified point to screen coordinates.
---
---@param windowHWND identifier
---@param x integer
---@param y integer
---@return integer x, integer y
function reaper.JS_Window_ClientToScreen(windowHWND, x, y) end

---Creates a modeless window with WS\_OVERLAPPEDWINDOW style and only rudimentary features. Scripts can paint into the window using GDI or LICE/Composite functions (and JS\_Window\_InvalidateRect to trigger re-painting).style: An optional parameter that overrides the default style. The string may include any combination of standard window styles, such as "POPUP" for a frameless window, or "CAPTION,SIZEBOX,SYSMENU" for a standard framed window.On Linux and macOS, "MAXIMIZE" has not yet been implemented, and the remaining styles may appear slightly different from their WindowsOS counterparts.className: On Windows, only standard ANSI characters are supported.ownerHWND: Optional parameter, only available on WindowsOS. Usually either the REAPER main window or another script window, and useful for ensuring that the created window automatically closes when the owner is closed.NOTE: On Linux and macOS, the window contents are only updated \*between\* defer cycles, so the window cannot be animated by for/while loops within a single defer cycle.
---@param title string
---@param className string
---@param x integer
---@param y integer
---@param w integer
---@param h integer
---@param style? string
---@param ownerHWND identifier
---@return identifier retval, string|nil style
function reaper.JS_Window_Create(title, className, x, y, w, h, style, ownerHWND) end

---Destroys the specified window.
---
---@param windowHWND identifier
function reaper.JS_Window_Destroy(windowHWND) end

---Enables or disables mouse and keyboard input to the specified window or control.
---
---@param windowHWND identifier
---@param enable boolean
function reaper.JS_Window_Enable(windowHWND, enable) end

---On macOS, returns the Metal graphics setting:
---2 = Metal enabled and support GetDC()/ReleaseDC() for drawing (more overhead).
---1 = Metal enabled.
---0 = N/A (Windows and Linux).
----1 = non-metal async layered mode.
----2 = non-metal non-async layered mode.WARNING: If using mode -1, any BitBlt()/StretchBlt() MUST have the source bitmap persist. If it is resized after Blit it could cause crashes.
---@param windowHWND identifier
---@return integer retval
function reaper.JS_Window_EnableMetal(windowHWND) end

---Returns a HWND to a window whose title matches the specified string.
---* Unlike the Win32 function FindWindow, this function searches top-level as well as child windows, so that the target window can be found irrespective of docked state.
---* In addition, the function can optionally match substrings of the title.
---* Matching is not case sensitive.Parameters:
---* exact: Match entire title, or match substring of title.
---@param title string
---@param exact boolean
---@return identifier hwnd
function reaper.JS_Window_Find(title, exact) end

---Returns a HWND to a child window whose title matches the specified string.Parameters: * exact: Match entire title length, or match substring of title. In both cases, matching is not case sensitive.
---
---@param parentHWND identifier
---@param title string
---@param exact boolean
---@return identifier hwnd
function reaper.JS_Window_FindChild(parentHWND, title, exact) end

---Similar to the C++ WIN32 function GetDlgItem, this function finds child windows by ID.(The ID of a window may be retrieved by JS\_Window\_GetLongPtr.)For instance: with Reaper's [MainHWND](#GetMainHwnd), you can get:
---    0: Transport(Windows)/MainHWND(Mac)
---    999: project-tabs(if existing, otherwise will be nil)
---    1000: trackview
---    1005: timeline
---    1259: Mouse editing help in the area beneath the track control panels
---@param parentHWND identifier
---@param ID integer
---@return identifier HWND
function reaper.JS_Window_FindChildByID(parentHWND, ID) end

---Returns a handle to a child window whose class and title match the specified strings.Parameters: * childWindow: The function searches child windows, beginning with the window *after* the specified child window. If childHWND is equal to parentHWND, the search begins with the first child window of parentHWND.
---* title: An empty string, "", will match all windows. (Search is not case sensitive.)
---@param parentHWND identifier
---@param childHWND identifier
---@param className string
---@param title string
---@return identifier HWND
function reaper.JS_Window_FindEx(parentHWND, childHWND, className, title) end

---Returns a HWND to a top-level window whose title matches the specified string.Parameters:
---* exact: Match entire title length, or match substring of title. In both cases, matching is not case sensitive.
---@param title string
---@param exact boolean
---@return identifier hwnd
function reaper.JS_Window_FindTop(title, exact) end

---Retrieves a HWND to the window that contains the specified point.
---
---@param x integer
---@param y integer
---@return identifier hwnd
function reaper.JS_Window_FromPoint(x, y) end

---WARNING: May not be fully implemented on MacOS and Linux.
---
---@param windowHWND identifier
---@param buf string
---@return string buf
function reaper.JS_Window_GetClassName(windowHWND, buf) end

---Retrieves the coordinates of the client area rectangle of the specified window. The dimensions are given in screen coordinates relative to the upper-left corner of the screen.NOTE 1: Unlike the C++ function GetClientRect, this function returns the actual coordinates, not the width and height.NOTE 2: The pixel at (right, bottom) lies immediately outside the rectangle.
---@param windowHWND identifier
---@return boolean retval, integer left, integer top, integer right, integer bottom
function reaper.JS_Window_GetClientRect(windowHWND) end

---Retrieves a HWND to the window that has the keyboard focus, if the window is attached to the calling thread's message queue.
---
---@param windowHWND identifier
---@return boolean retval, integer width, integer height
function reaper.JS_Window_GetClientSize(windowHWND) end

---Retrieves a HWND to the window that has the keyboard focus, if the window is attached to the calling thread's message queue.
---
---@return identifier hwnd
function reaper.JS_Window_GetFocus() end

---Retrieves a HWND to the top-level foreground window (the window with which the user is currently working).
---@return identifier hwnd
function reaper.JS_Window_GetForeground() end

---In the case of "DLGPROC" and "WNDPROC", the return values can be converted to pointers by [JS\_Window\_HandleFromAddress](#JS_Window_HandleFromAddress).If the function fails, the return value is 0.
---@param windowHWND identifier
---@param info string
---@return number retval
function reaper.JS_Window_GetLong(windowHWND, info) end

---Returns information about the specified window.info: "USERDATA", "WNDPROC", "DLGPROC", "ID", "EXSTYLE" or "STYLE".For documentation about the types of information returned, refer to the Win32 function GetWindowLongPtr.
---The values returned by "DLGPROC" and "WNDPROC" are typically used as-is, as pointers, whereas the others should first be converted to integers.
---
---@param windowHWND identifier
---@param info string
---@return identifier long_ptr
function reaper.JS_Window_GetLongPtr(windowHWND, info) end

---Retrieves a HWND to the specified window's parent or owner.Returns NULL if the window is unowned or if the function otherwise fails.
---@param windowHWND identifier
---@return identifier hwnd
function reaper.JS_Window_GetParent(windowHWND) end

---Retrieves the coordinates of the bounding rectangle of the specified window. The dimensions are given in screen coordinates relative to the upper-left corner of the screen.NOTE: The pixel at (right, bottom) lies immediately outside the rectangle.
---@param windowHWND identifier
---@return boolean retval, integer left, integer top, integer right, integer bottom
function reaper.JS_Window_GetRect(windowHWND) end

---Retrieves a handle to a window that has the specified relationship (Z-Order or owner) to the specified window.relation: "LAST", "NEXT", "PREV", "OWNER" or "CHILD".(Refer to documentation for Win32 C++ function GetWindow.)
---@param windowHWND identifier
---@param relation string
---@return identifier hwnd
function reaper.JS_Window_GetRelated(windowHWND, relation) end

---Retrieves the scroll information of a window.Parameters:
---* scrollbar: "v" (or "SB_VERT", or "VERT") for vertical scroll, "h" (or "SB_HORZ" or "HORZ") for horizontal.Returns:
---* Leftmost or topmost visible pixel position, as well as the visible page size, the range minimum and maximum, and scroll box tracking position.
---
---@param windowHWND identifier
---@param scrollbar string
---@return boolean retval, integer position, integer pageSize, integer min, integer max, integer trackPos
function reaper.JS_Window_GetScrollInfo(windowHWND, scrollbar) end

---Returns the title (if any) of the specified window.
---
---@param windowHWND identifier
---@return string title
function reaper.JS_Window_GetTitle(windowHWND) end

---Retrieves the dimensions of the display monitor that has the largest area of intersection with the specified rectangle.If the monitor is not the primary display, some of the rectangle's coordinates may be negative.wantWork: Returns the work area of the display, which excludes the system taskbar or application desktop toolbars.
---@param x1 integer
---@param y1 integer
---@param x2 integer
---@param y2 integer
---@param wantWork boolean
---@return integer left, integer top, integer right, integer bottom
function reaper.JS_Window_GetViewportFromRect(x1, y1, x2, y2, wantWork) end

---Converts an address to a handle (such as a HWND) that can be utilized by REAPER and other API functions.
---
---@param address number
---@return identifier hwnd
function reaper.JS_Window_HandleFromAddress(address) end

---Similar to the Win32 function InvalidateRect.
---
---@param windowHWND identifier
---@param left integer
---@param top integer
---@param right integer
---@param bottom integer
---@param eraseBackground boolean
---@return boolean retval
function reaper.JS_Window_InvalidateRect(windowHWND, left, top, right, bottom, eraseBackground) end

---Determines whether a window is a child window or descendant window of a specified parent window.
---
---@param parentHWND identifier
---@param childHWND identifier
---@return boolean retval
function reaper.JS_Window_IsChild(parentHWND, childHWND) end

---Determines the visibility state of the window.
---
---@param windowHWND identifier
---@return boolean retval
function reaper.JS_Window_IsVisible(windowHWND) end

---Determines whether the specified window handle identifies an existing window.On macOS and Linux, only windows that were created by WDL/swell will be identified (and only such windows should be acted on by scripts).NOTE: Since REAPER v5.974, windows can be checked using the native function ValidatePtr(windowHWND, "HWND").
---@param windowHWND identifier
---@return boolean retval
function reaper.JS_Window_IsWindow(windowHWND) end

---Finds all child windows of the specified parent.Returns:
---\* retval: The number of windows found; negative if an error occurred.
---\* list: A comma-separated string of hexadecimal values.
---Each value is an address that can be converted to a HWND by the function JS\_Window\_HandleFromAddress.
---@param parentHWND identifier
---@return integer retval, string list
function reaper.JS_Window_ListAllChild(parentHWND) end

---Finds all top-level windows.Returns:
---\* retval: The number of windows found; negative if an error occurred.
---\* list: A comma-separated string of hexadecimal values. Each value is an address that can be converted to a HWND by the function JS\_Window\_HandleFromAddress.
---@return integer retval, string list
function reaper.JS_Window_ListAllTop() end

---Finds all windows (whether top-level or child) whose titles match the specified string.Returns:
---\* retval: The number of windows found; negative if an error occurred.
---\* list: A comma-separated string of hexadecimal values. Each value is an address that can be converted to a HWND by the function JS\_Window\_HandleFromAddress.Parameters:
---\* exact: Match entire title exactly, or match substring of title.
---@param title string
---@param exact boolean
---@return integer retval, string list
function reaper.JS_Window_ListFind(title, exact) end

---Deprecated - use [GetViewportFromRect](#GetViewportFromRect) instead.
---@param x1 integer
---@param y1 integer
---@param x2 integer
---@param y2 integer
---@param wantWork boolean
---@return integer left, integer top, integer right, integer bottom
function reaper.JS_Window_MonitorFromRect(x1, y1, x2, y2, wantWork) end

---Changes the position of the specified window, keeping its size constant.NOTES:
---* For top-level windows, position is relative to the primary display.
---* On Windows and Linux, position is calculated as the coordinates of the upper left corner of the window, relative to upper left corner of the primary display, and the positive Y-axis points downward.
---* On macOS, position is calculated as the coordinates of the bottom left corner of the window, relative to bottom left corner of the display, and the positive Y-axis points upward.
---* For a child window, on all platforms, position is relative to the upper-left corner of the parent window's client area.
---* Equivalent to calling [JS\_Window\_SetPosition](#JS_Window_SetPosition) with NOSIZE, NOZORDER, NOACTIVATE and NOOWNERZORDER flags set.
---@param windowHWND identifier
---@param left integer
---@param top integer
function reaper.JS_Window_Move(windowHWND, left, top) end

---Sends a "WM\_COMMAND" message to the specified window, which simulates a user selecting a command in the window menu.This function is similar to Main\_OnCommand and MIDIEditor\_OnCommand, but can send commands to any window that has a menu.In the case of windows that are listed among the Action list's contexts (such as the Media Explorer), the commandIDs of the actions in the Actions list may be used.
---@param windowHWND identifier
---@param commandID integer
---@return boolean retval
function reaper.JS_Window_OnCommand(windowHWND, commandID) end

---deprecated, removed from JS_0.952 and later
---@param windowHWND identifier
---@param remove boolean
---@return boolean retval
function reaper.JS_Window_RemoveXPStyle(windowHWND, remove) end

---Changes the dimensions of the specified window, keeping the top left corner position constant.* If resizing script GUIs, call gfx.update() after resizing.* Equivalent to calling [JS\_Window\_SetPosition](#JS_Window_SetPosition) with NOMOVE, NOZORDER, NOACTIVATE and NOOWNERZORDER flags set.
---@param windowHWND identifier
---@param width integer
---@param height integer
function reaper.JS_Window_Resize(windowHWND, width, height) end

---Converts the screen coordinates of a specified point on the screen to client-area coordinates.
---
---@param windowHWND identifier
---@param x integer
---@param y integer
---@return integer x, integer y
function reaper.JS_Window_ScreenToClient(windowHWND, x, y) end

---Sets the keyboard focus to the specified window.
---
---@param windowHWND identifier
function reaper.JS_Window_SetFocus(windowHWND) end

---Brings the specified window into the foreground, activates the window, and directs keyboard input to it.
---
---@param windowHWND identifier
function reaper.JS_Window_SetForeground(windowHWND) end

---Similar to the Win32 function SetWindowLongPtr. info: "USERDATA", "WNDPROC", "DLGPROC", "ID", "EXSTYLE" or "STYLE", and only on WindowOS, "INSTANCE" and "PARENT".
---@param windowHWND identifier
---@param info string
---@param value number
---@return number retval
function reaper.JS_Window_SetLong(windowHWND, info, value) end

---Sets the window opacity.Parameters:  
---mode: either "ALPHA" or "COLOR".  
---value: If ALPHA, the specified value may range from zero to one, and will apply to the entire window, frame included.  
---If COLOR, value specifies a 0xRRGGBB color, and all pixels of this color will be made transparent. (All mouse clicks over transparent pixels will pass through, too).  WARNING: COLOR mode is only available in Windows, not Linux or macOS.Transparency can only be applied to top-level windows. If windowHWND refers to a child window, the entire top-level window that contains windowHWND will be made transparent.  
---@param windowHWND identifier
---@param mode string
---@param value number
---@return boolean retval
function reaper.JS_Window_SetOpacity(windowHWND, mode, value) end

---If successful, returns a handle to the previous parent window.Only on WindowsOS: If parentHWND is not specified, the desktop window becomes the new parent window.
---@param childHWND identifier
---@param parentHWND identifier
---@return identifier hwnd
function reaper.JS_Window_SetParent(childHWND, parentHWND) end

---Interface to the Win32/swell function SetWindowPos, with which window position, size, Z-order and visibility can be set, and new frame styles can be applied.ZOrder and flags are optional parameters. If no arguments are supplied, the window will simply be moved and resized, as if the NOACTIVATE, NOZORDER, NOOWNERZORDER flags were set.
---* ZOrder: "BOTTOM", "TOPMOST", "NOTOPMOST", "TOP" or a window HWND converted to a string, for example by the Lua function tostring.
---* flags: Any combination of the standard flags, of which "NOMOVE", "NOSIZE", "NOZORDER", "NOACTIVATE", "SHOWWINDOW", "FRAMECHANGED" and "NOCOPYBITS" should be valid cross-platform.
---@param windowHWND identifier
---@param left integer
---@param top integer
---@param width integer
---@param height integer
---@param ZOrder? string
---@param flags? string
---@return boolean retval, string|nil ZOrder, string|nil flags
function reaper.JS_Window_SetPosition(windowHWND, left, top, width, height, ZOrder, flags) end

---Parameters:* scrollbar: "v" (or "SB_VERT", or "VERT") for vertical scroll, "h" (or "SB_HORZ" or "HORZ") for horizontal.           NOTE: API functions can scroll REAPER's windows, but cannot zoom them.  Instead, use actions such as "View: Zoom to one loop iteration".
---
---@param windowHWND identifier
---@param scrollbar string
---@param position integer
---@return boolean retval
function reaper.JS_Window_SetScrollPos(windowHWND, scrollbar, position) end

---Sets and applies a window style.style may include any combination of standard window styles, such as "POPUP" for a frameless window, or "CAPTION,SIZEBOX,SYSMENU" for a standard framed window.On Linux and macOS, "MAXIMIZE" has not yet been implmented, and the remaining styles may appear slightly different from their WindowsOS counterparts.
---@param windowHWND identifier
---@param style string
---@return boolean retval, string style
function reaper.JS_Window_SetStyle(windowHWND, style) end

---Changes the title of the specified window. Returns true if successful.
---
---@param windowHWND identifier
---@param title string
---@return boolean retval
function reaper.JS_Window_SetTitle(windowHWND, title) end

---Sets the window Z order.
---* Equivalent to calling JS_Window_SetPos with flags NOMOVE | NOSIZE.
---* Not all the Z orders have been implemented in Linux yet.Parameters:
---* ZOrder: "BOTTOM", "TOPMOST", "NOTOPMOST", "TOP", or a window HWND converted to a string, for example by the Lua function tostring.* InsertAfterHWND: For compatibility with older versions, this parameter is still available, and is optional. If ZOrder is "INSERTAFTER", insertAfterHWND must be a handle to the window behind which windowHWND will be placed in the Z order, equivalent to setting ZOrder to this HWND; otherwise, insertAfterHWND is ignored and can be left out (or it can simply be set to the same value as windowHWND).
---@param windowHWND identifier
---@param ZOrder string
---@param insertAfterHWND identifier
---@return boolean retval
function reaper.JS_Window_SetZOrder(windowHWND, ZOrder, insertAfterHWND) end

---Sets the specified window's show state.Parameters:
---* state: One of the following options: "SHOW", "SHOWNA" (or "SHOWNOACTIVATE"), "SHOWMINIMIZED", "HIDE", "NORMAL", "SHOWNORMAL", "SHOWMAXIMIZED", "SHOWDEFAULT" or "RESTORE".On Linux and macOS, only the first four options are fully implemented.
---
---@param windowHWND identifier
---@param state string
function reaper.JS_Window_Show(windowHWND, state) end

---Similar to the Win32 function UpdateWindow.
---@param windowHWND identifier
function reaper.JS_Window_Update(windowHWND) end

---Closes the zip archive, using either the file name or the zip handle. Finalizes entries and releases resources.
---@param zipFile string
---@param zipHandle identifier
---@return integer retval
function reaper.JS_Zip_Close(zipFile, zipHandle) end

---@param zipHandle identifier
---@return integer retval
function reaper.JS_Zip_CountEntries(zipHandle) end

---Deletes the specified entries from an existing Zip file.entryNames is zero-separated and double-zero-terminated.Returns the number of deleted entries on success, negative number (< 0) on error.
---@param zipHandle identifier
---@param entryNames string
---@param entryNamesStrLen integer
---@return integer retval
function reaper.JS_Zip_DeleteEntries(zipHandle, entryNames, entryNamesStrLen) end

---Closes a zip entry, flushes buffer and releases resources. In WRITE mode, entries must be closed in order to apply and save changes.Returns 0 on success, negative number (< 0) on error.
---@param zipHandle identifier
---@return integer retval
function reaper.JS_Zip_Entry_Close(zipHandle) end

---Compresses the specified file into the zip archive's open entry.Returns 0 on success, negative number (< 0) on error.
---@param zipHandle identifier
---@param inputFile string
---@return integer retval
function reaper.JS_Zip_Entry_CompressFile(zipHandle, inputFile) end

---Compresses the specified memory buffer into the zip archive's open entry.Returns 0 on success, negative number (< 0) on error.
---@param zipHandle identifier
---@param buf string
---@param buf_size integer
---@return integer retval
function reaper.JS_Zip_Entry_CompressMemory(zipHandle, buf, buf_size) end

---Extracts the zip archive's open entry.Returns 0 on success, negative number (< 0) on error.
---@param zipHandle identifier
---@param outputFile string
---@return integer retval
function reaper.JS_Zip_Entry_ExtractToFile(zipHandle, outputFile) end

---Extracts and returns the zip archive's open entry.Returns the number of bytes extracted on success, negative number (< 0) on error.
---@param zipHandle identifier
---@return integer retval, string contents
function reaper.JS_Zip_Entry_ExtractToMemory(zipHandle) end

---Returns information about the zip archive's open entry.
---@param zipHandle identifier
---@return integer retval, string name, integer index, integer isFolder, number size, number crc32
function reaper.JS_Zip_Entry_Info(zipHandle) end

---Opens a new entry by index in the zip archive.This function is only valid if zip archive was opened in 'r' (readonly) mode.Returns 0 on success, negative number on error.
---@param zipHandle identifier
---@param index integer
---@return integer retval
function reaper.JS_Zip_Entry_OpenByIndex(zipHandle, index) end

---Opens an entry by name in the zip archive.For zip archive opened in 'w' or 'a' mode the function will append a new entry. In readonly mode the function tries to locate an existing entry.Returns 0 on success, negative number (< 0) on error.
---@param zipHandle identifier
---@param entryName string
---@return integer retval
function reaper.JS_Zip_Entry_OpenByName(zipHandle, entryName) end

---Returns a descriptive string for the given error code.
---@param errorNum integer
---@return string errorStr
function reaper.JS_Zip_ErrorString(errorNum) end

---Extracts an existing Zip file to the specified folder.Returns the number of extracted files on success, negative number (< 0) on error.
---@param zipFile string
---@param outputFolder string
---@return integer retval
function reaper.JS_Zip_Extract(zipFile, outputFolder) end

---Returns the number of entries and a zero-separated and double-zero-terminated string of entry names.On error, returns a negative number (< 0).
---@param zipHandle identifier
---@return integer retval, string list
function reaper.JS_Zip_ListAllEntries(zipHandle) end

---@param zipFile string
---@param mode string
---@param compressionLevel integer
---@return identifier retval, integer retval
function reaper.JS_Zip_Open(zipFile, mode, compressionLevel) end

---retval is 1 if a folder was selected, 0 if the user canceled the dialog, and -1 if an error occurred.
---@param caption string
---@param initialFolder string
---@return integer retval, string folder
function reaper.JS_Dialog_BrowseForFolder(caption, initialFolder) end

---If allowMultiple is true, multiple files may be selected. The returned string is \0-separated, with the first substring containing the folder path and subsequent substrings containing the file names.
---* On macOS, the first substring may be empty, and each file name will then contain its entire path.
---* This function only allows selection of existing files, and does not allow creation of new files.extensionList is a string containing pairs of \0-terminated substrings. The last substring must be terminated by two \0 characters. Each pair defines one filter pattern:
---* The first substring in each pair describes the filter in user-readable form (for example, "Lua script files (*.lua)") and will be displayed in the dialog box.
---* The second substring specifies the filter that the operating system must use to search for the files (for example, "*.txt"; the wildcard should not be omitted). To specify multiple extensions for a single display string, use a semicolon to separate the patterns (for example, "*.lua;*.eel").An example of an extensionList string:
---"ReaScript files\0*.lua;*.eel\0Lua files (.lua)\0*.lua\0EEL files (.eel)\0*.eel\0\0".On macOS, file dialogs do not accept empty extensionLists, nor wildcard extensions (such as "All files\0*.*\0\0"), so each acceptable extension must be listed explicitly. On Linux and Windows, wildcard extensions are acceptable, and if the extensionList string is empty, the dialog will display a default "All files (*.*)" filter.retval is 1 if one or more files were selected, 0 if the user cancelled the dialog, or negative if an error occurred.Displaying \0-separated strings:
---* REAPER's IDE and ShowConsoleMsg only display strings up to the first \0 byte. If multiple files were selected, only the first substring containing the path will be displayed. This is not a problem for Lua or EEL, which can access the full string beyond the first \0 byte as usual.
---@param windowTitle string
---@param initialFolder string
---@param initialFile string
---@param extensionList string
---@param allowMultiple boolean
---@return integer retval, string fileNames
function reaper.JS_Dialog_BrowseForOpenFiles(windowTitle, initialFolder, initialFile, extensionList, allowMultiple) end

---Opens a file-chooser-dialog for saving operations.retval is 1 if a file was selected, 0 if the user cancelled the dialog, or negative if an error occurred.extensionList is a string containing pairs of 0-terminated substrings. The last substring must be terminated by two 0 characters. Each pair defines one filter pattern:
---* The first substring in each pair describes the filter in user-readable form (for example, "Lua script files (*.lua)") and will be displayed in the dialog box.
---* The second substring specifies the filter that the operating system must use to search for the files (for example, "*.txt"; the wildcard should not be omitted). To specify multiple extensions for a single display string, use a semicolon to separate the patterns (for example, "*.lua;*.eel").An example of an extensionList string:
---"ReaScript files\0*.lua;*.eel\0Lua files (.lua)\0*.lua\0EEL files (.eel)\0*.eel\0\0".If the extensionList string is empty, it will display the default "All files (*.*)" filter.
---@param windowTitle string
---@param initialFolder string
---@param initialFile string
---@param extensionList string
---@return integer retval, string fileName
function reaper.JS_Dialog_BrowseForSaveFile(windowTitle, initialFolder, initialFile, extensionList) end

---Returns the index of the next selected list item with index greater that the specified number. Returns -1 if no selected items left.
---@param listviewHWND identifier
---@param index integer
---@return integer retval
function reaper.JS_ListView_EnumSelItems(listviewHWND, index) end

---Returns the index and text of the focused item, if any.
---@param listviewHWND identifier
---@return integer retval, string text
function reaper.JS_ListView_GetFocusedItem(listviewHWND) end

---Returns the index and text of the focused item, if any.
---@param listviewHWND identifier
---@return identifier index
function reaper.JS_ListView_GetHeader(listviewHWND) end

---Returns the text and state of specified item.
---@param listviewHWND identifier
---@param index integer
---@param subItem integer
---@return string text, integer state
function reaper.JS_ListView_GetItem(listviewHWND, index, subItem) end

---@param listviewHWND identifier
---@return integer retval
function reaper.JS_ListView_GetItemCount(listviewHWND) end

---Returns client coordinates of the item.
---@param listviewHWND identifier
---@param index integer
---@return boolean retval, integer left, integer top, integer right, integer bottom
function reaper.JS_ListView_GetItemRect(listviewHWND, index) end

---State is a bitmask:
---1 = focused, 2 = selected. On Windows only, cut-and-paste marked = 4, drag-and-drop highlighted = 8.Warning: this function uses the Win32 bitmask values, which differ from the values used by WDL/swell.
---@param listviewHWND identifier
---@param index integer
---@return integer retval
function reaper.JS_ListView_GetItemState(listviewHWND, index) end

---@param listviewHWND identifier
---@param index integer
---@param subItem integer
---@return string text
function reaper.JS_ListView_GetItemText(listviewHWND, index, subItem) end

---@param listviewHWND identifier
---@return integer retval
function reaper.JS_ListView_GetSelectedCount(listviewHWND) end

---@param listviewHWND identifier
---@return integer retval
function reaper.JS_ListView_GetTopIndex(listviewHWND) end

---@param listviewHWND identifier
---@param clientX integer
---@param clientY integer
---@return integer index, integer subItem, integer flags
function reaper.JS_ListView_HitTest(listviewHWND, clientX, clientY) end

---Returns the indices of all selected items as a comma-separated list.* retval: Number of selected items found; negative or zero if an error occured.
---@param listviewHWND identifier
---@return integer retval, string items
function reaper.JS_ListView_ListAllSelItems(listviewHWND) end

---The mask parameter specifies the state bits that must be set, and the state parameter specifies the new values for those bits.1 = focused, 2 = selected. On Windows only, cut-and-paste marked = 4, drag-and-drop highlighted = 8.Warning: this function uses the Win32 bitmask values, which differ from the values used by WDL/swell.
---@param listviewHWND identifier
---@param index integer
---@param state integer
---@param mask integer
function reaper.JS_ListView_SetItemState(listviewHWND, index, state, mask) end

---Currently, this function only accepts ASCII text.
---@param listviewHWND identifier
---@param index integer
---@param subItem integer
---@param text string
function reaper.JS_ListView_SetItemText(listviewHWND, index, subItem, text) end

---Creates writer for 32 bit floating point WAV
---@param filename string
---@param numchans integer
---@param samplerate integer
---@return AudioWriter writer
function reaper.Xen_AudioWriter_Create(filename, numchans, samplerate) end

---Destroys writer
---@param writer AudioWriter
function reaper.Xen_AudioWriter_Destroy(writer) end

---Write interleaved audio data to disk
---@param writer AudioWriter
---@param numframes integer
---@param data identifier
---@param offset integer
---@return integer retval
function reaper.Xen_AudioWriter_Write(writer, numframes, data, offset) end

---Get interleaved audio data from media source
---@param src PCM_source
---@param destbuf identifier
---@param destbufoffset integer
---@param numframes integer
---@param numchans integer
---@param samplerate number
---@param sourceposition number
---@return integer retval
function reaper.Xen_GetMediaSourceSamples(src, destbuf, destbufoffset, numframes, numchans, samplerate, sourceposition) end

---Start audio preview of a PCM\_source, which can be created using functions like [PCM\_Source\_CreateFromFile](#PCM_Source_CreateFromFile)Returns id of a preview handle that can be provided to [Xen\_StopSourcePreview](#Xen_StopSourcePreview).If the given PCM\_source does not belong to an existing MediaItem/Take, it will be deleted by the preview system when the preview is stopped.You can preview more than one file at the same time.
---@param source PCM_source
---@param gain number
---@param loop boolean
---@param outputchanindex? integer
---@return integer retval
function reaper.Xen_StartSourcePreview(source, gain, loop, outputchanindex) end

---Stop audio preview. To stop all running previews, set id=-1
---@param preview_id integer
---@return integer retval
function reaper.Xen_StopSourcePreview(preview_id) end

---Called with parameter value 1 executes one ReaLlm cycle. E.g. for running ReaLlm on custom timer, or deferred. 0 or nothing performs shutdown. Disarming/disabling all monitored inputs and calling with parameter value 1 equals to shutdown.
---@param param? integer
function reaper.Llm_Do(param) end

---Get ReaLlm information string. Zero-based indices. Master track index -1. Optional MediaTrack* tr gets results relative to tr. Each line (newline '\n' separated) represents entry. Tracks are separated with ';'. FX are listed after ':' separated with ','.
---GRAPH : Mixer routings as network graph in format "node;neighborhood\n" where node is track, and neighborhood is group of tracks in format "track;tr#1;tr#2...\n". Or as "parent;children\n" where first field is parent and rest are children. Or as multiply linked list where first field is node and rest are links. E.g. "7;1;-1;\n" would mean "8th track is connected to 2nd track and Master track."
---PDCLATENCY : Latency in samples.
---PDCLIMIT : Limit in samples.
---REALLM or STATE : Current state of ReaLlm as approach vektors with disabled FX in format: "begin:disabled fx,...;next:fx,...;end:fx,...;\n." E.g. "3:1,2;0;-1:0\n" would be: 4th track, fx#2 and #3 disabled => 1st track, nofx disabled => Master track, fx#1 disabled.
---SAFE : 'Safed' plugins as "track#:fx#\n" pairs.
---VECTOR : Same as REALLM without FX information. Faster.
---@param parmname string
---@param buf string
---@param tr MediaTrack
---@return string buf
function reaper.Llm_Get(parmname, buf, tr) end

---Set ReaLlm parameters.
---PDCLIMIT : PDC latency limit in audio blocks/buffers, e.g. "1.5".
---MONITORINGFX : Use any non-empty string to include Monitoring FX. E.g. "true".
---PARAMCHANGE : Instead of bypassing, changes FX parameter between val1 (low latency) and val2 (original). Use bufIn string format 'fx_name,param_index,val1,val2'.
---@param parmname string
---@param buf string
function reaper.Llm_Set(parmname, buf) end

---[BR] Equivalent to win32 API ComboBox_FindString().
---
---@param comboBoxHwnd identifier
---@param startId integer
---@param string string
---@return integer retval
function reaper.BR_Win32_CB_FindString(comboBoxHwnd, startId, string) end

---[BR] Equivalent to win32 API ComboBox_FindStringExact().
---
---@param comboBoxHwnd identifier
---@param startId integer
---@param string string
---@return integer retval
function reaper.BR_Win32_CB_FindStringExact(comboBoxHwnd, startId, string) end

---[BR] Equivalent to win32 API ClientToScreen().
---@param hwnd identifier
---@param x integer
---@param y integer
---@return integer x, integer y
function reaper.BR_Win32_ClientToScreen(hwnd, x, y) end

---[BR] Equivalent to win32 API FindWindowEx(). Since ReaScript doesn't allow passing NULL (None in Python, nil in Lua etc...) parameters, to search by supplied class or name set searchClass and searchName accordingly. HWND parameters should be passed as either "0" to signify NULL or as string obtained from [BR\_Win32_HwndToString](#BR_Win32_HwndToString).
---
---@param hwndParent string
---@param hwndChildAfter string
---@param className string
---@param windowName string
---@param searchClass boolean
---@param searchName boolean
---@return identifier hwnd
function reaper.BR_Win32_FindWindowEx(hwndParent, hwndChildAfter, className, windowName, searchClass, searchName) end

---[BR] Equivalent to win32 API GET_X_LPARAM().
---
---@param lParam integer
---@return integer retval
function reaper.BR_Win32_GET_X_LPARAM(lParam) end

---[BR] Equivalent to win32 API GET_Y_LPARAM().
---
---@param lParam integer
---@return integer retval
function reaper.BR_Win32_GET_Y_LPARAM(lParam) end

---[BR] Returns various constants needed for BR_Win32 functions.
---Supported constants are:
---CB_ERR, CB_GETCOUNT, CB_GETCURSEL, CB_SETCURSEL
---EM_SETSEL
---GW_CHILD, GW_HWNDFIRST, GW_HWNDLAST, GW_HWNDNEXT, GW_HWNDPREV, GW_OWNER
---GWL_STYLE
---SW_HIDE, SW_MAXIMIZE, SW_SHOW, SW_SHOWMINIMIZED, SW_SHOWNA, SW_SHOWNOACTIVATE, SW_SHOWNORMAL
---SWP_FRAMECHANGED, SWP_FRAMECHANGED, SWP_NOMOVE, SWP_NOOWNERZORDER, SWP_NOSIZE, SWP_NOZORDER
---VK_DOWN, VK_UP
---WM_CLOSE, WM_KEYDOWN
---WS_MAXIMIZE, WS_OVERLAPPEDWINDOW
---
---@param constantName string
---@return integer retval
function reaper.BR_Win32_GetConstant(constantName) end

---[BR] Equivalent to win32 API GetCursorPos().
---
---@return boolean retval, integer x, integer y
function reaper.BR_Win32_GetCursorPos() end

---[BR] Equivalent to win32 API GetFocus().
---
---@return identifier hwnd_focus
function reaper.BR_Win32_GetFocus() end

---[BR] Equivalent to win32 API GetForegroundWindow().
---
---@return identifier hwnd_foreground
function reaper.BR_Win32_GetForegroundWindow() end

---[BR] Alternative to [GetMainHwnd](#GetMainHwnd). REAPER seems to have problems with extensions using HWND type for exported functions so all BR_Win32 functions use void* instead of HWND type
---
---@return identifier hwnd_main
function reaper.BR_Win32_GetMainHwnd() end

---[BR] Get mixer window HWND. isDockedOut will be set to true if mixer is docked
---
---@return identifier retval, boolean isDocked
function reaper.BR_Win32_GetMixerHwnd() end

---[BR] Get coordinates for screen which is nearest to supplied coordinates. Pass workingAreaOnly as true to get screen coordinates excluding taskbar (or menu bar on OSX).
---
---@param workingAreaOnly boolean
---@param left integer
---@param top integer
---@param right integer
---@param bottom integer
---@return integer left, integer top, integer right, integer bottom
function reaper.BR_Win32_GetMonitorRectFromRect(workingAreaOnly, left, top, right, bottom) end

---[BR] Equivalent to win32 API GetParent().
---
---@param hwnd identifier
---@return identifier hwnd_parent
function reaper.BR_Win32_GetParent(hwnd) end

---[BR] Equivalent to win32 API GetWindow().
---
---@param hwnd identifier
---@param cmd integer
---@return identifier hwnd
function reaper.BR_Win32_GetWindow(hwnd, cmd) end

---[BR] Equivalent to win32 API GetWindowLong().
---
---@param hwnd identifier
---@param index integer
---@return integer retval
function reaper.BR_Win32_GetWindowLong(hwnd, index) end

---[BR] Equivalent to win32 API GetWindowRect().
---
---@param hwnd identifier
---@return boolean retval, integer left, integer top, integer right, integer bottom
function reaper.BR_Win32_GetWindowRect(hwnd) end

---[BR] Equivalent to win32 API GetWindowText().
---
---@param hwnd identifier
---@return integer retval, string text
function reaper.BR_Win32_GetWindowText(hwnd) end

---[BR] Equivalent to win32 API HIBYTE().
---
---@param value integer
---@return integer retval
function reaper.BR_Win32_HIBYTE(value) end

---[BR] Equivalent to win32 API HIWORD().
---
---@param value integer
---@return integer retval
function reaper.BR_Win32_HIWORD(value) end

---[BR] Convert HWND to string. To convert string back to HWND, see [BR\_Win32_StringToHwnd](#BR_Win32_StringToHwnd).A way to share a hwnd via extstate, which only allows strings, not binary objects.
---@param hwnd identifier
---@return string hwndstring
function reaper.BR_Win32_HwndToString(hwnd) end

---[BR] Equivalent to win32 API IsWindow().
---
---@param hwnd identifier
---@return boolean retval
function reaper.BR_Win32_IsWindow(hwnd) end

---[BR] Equivalent to win32 API IsWindowVisible().
---
---@param hwnd identifier
---@return boolean retval
function reaper.BR_Win32_IsWindowVisible(hwnd) end

---[BR] Equivalent to win32 API LOBYTE().
---@param value integer
---@return integer retval
function reaper.BR_Win32_LOBYTE(value) end

---[BR] Equivalent to win32 API LOWORD().
---
---@param value integer
---@return integer retval
function reaper.BR_Win32_LOWORD(value) end

---[BR] Equivalent to win32 API MAKELONG().
---
---@param low integer
---@param high integer
---@return integer retval
function reaper.BR_Win32_MAKELONG(low, high) end

---[BR] Equivalent to win32 API MAKELPARAM().
---
---@param low integer
---@param high integer
---@return integer retval
function reaper.BR_Win32_MAKELPARAM(low, high) end

---[BR] Equivalent to win32 API MAKELRESULT().
---
---@param low integer
---@param high integer
---@return integer retval
function reaper.BR_Win32_MAKELRESULT(low, high) end

---[BR] Equivalent to win32 API MAKEWORD().
---
---@param low integer
---@param high integer
---@return integer retval
function reaper.BR_Win32_MAKEWORD(low, high) end

---[BR] Equivalent to win32 API MAKEWPARAM().
---
---@param low integer
---@param high integer
---@return integer retval
function reaper.BR_Win32_MAKEWPARAM(low, high) end

---[BR] Alternative to [MIDIEditor\_GetActive](#MIDIEditor_GetActive). REAPER seems to have problems with extensions using HWND type for exported functions so all BR\_Win32 functions use void* instead of HWND type.
---
---@return identifier hwnd_active_midi_ed
function reaper.BR_Win32_MIDIEditor_GetActive() end

---[BR] Equivalent to win32 API ClientToScreen().
---
---@param hwnd identifier
---@param x integer
---@param y integer
---@return integer x, integer y
function reaper.BR_Win32_ScreenToClient(hwnd, x, y) end

---[BR] Equivalent to win32 API SendMessage().
---
---@param hwnd identifier
---@param msg integer
---@param lParam integer
---@param wParam integer
---@return integer retval
function reaper.BR_Win32_SendMessage(hwnd, msg, lParam, wParam) end

---[BR] Equivalent to win32 API SetFocus().
---
---@param hwnd identifier
---@return identifier hwnd_focus
function reaper.BR_Win32_SetFocus(hwnd) end

---[BR] Equivalent to win32 API SetForegroundWindow().
---
---@param hwnd identifier
---@return integer retval
function reaper.BR_Win32_SetForegroundWindow(hwnd) end

---[BR] Equivalent to win32 API SetWindowLong().
---
---@param hwnd identifier
---@param index integer
---@param newLong integer
---@return integer retval
function reaper.BR_Win32_SetWindowLong(hwnd, index, newLong) end

---[BR] Equivalent to win32 API SetWindowPos().
---hwndInsertAfter may be a string: "HWND\_BOTTOM", "HWND\_NOTOPMOST", "HWND\_TOP", "HWND\_TOPMOST" or a string obtained with [BR\_Win32_HwndToString](#BR_Win32_HwndToString).
---
---@param hwnd identifier
---@param hwndInsertAfter string
---@param x integer
---@param y integer
---@param width integer
---@param height integer
---@param flags integer
---@return boolean retval
function reaper.BR_Win32_SetWindowPos(hwnd, hwndInsertAfter, x, y, width, height, flags) end

---[BR] Equivalent to win32 API ShowWindow().
---
---@param hwnd identifier
---@param cmdShow integer
---@return boolean retval
function reaper.BR_Win32_ShowWindow(hwnd, cmdShow) end

---[BR] Convert string to HWND. To convert HWND back to string, see [BR\_Win32\_HwndToString](BR_Win32_HwndToString).A way to share a hwnd via extstate, which only allows strings, not binary objects.
---@param string string
---@return identifier hwnd
function reaper.BR_Win32_StringToHwnd(string) end

---[BR] Equivalent to win32 API WindowFromPoint().
---@param x integer
---@param y integer
---@return identifier hwnd_point
function reaper.BR_Win32_WindowFromPoint(x, y) end

---Create a new preview object. Does not take ownership of the source (don't forget to destroy it unless it came from a take!). See CF_Preview_Play and the others CF_Preview_* functions.The preview object is automatically destroyed at the end of a defer cycle if at least one of these conditions are met:
---- playback finished
---- playback was not started using CF_Preview_Play
---- the output track no longer exists
---@param source PCM_source
---@return CF_Preview retval
function reaper.CF_CreatePreview(source) end

---Enumerate the source's media cues. Returns the next index or 0 when finished.
---@param src PCM_source
---@param index integer
---@return integer retval, number time, number endTime, boolean isRegion, string name, boolean isChapter
function reaper.CF_EnumMediaSourceCues(src, index) end

---Return the index of the next selected effect in the given FX chain. Start index should be -1. Returns -1 if there are no more selected effects.
---
---@param hwnd FxChain
---@param index integer
---@return integer retval
function reaper.CF_EnumSelectedFX(hwnd, index) end

---Deprecated, see kbd_enumerateActions (v6.71+). Wrapper for the unexposed kbd_enumerateActions API function.
---Main=0, Main (alt recording)=100, MIDI Editor=32060, MIDI Event List Editor=32061, MIDI Inline Editor=32062, Media Explorer=32063
---@param section integer
---@param index integer
---@return integer retval, string name
function reaper.CF_EnumerateActions(section, index) end

---Export the source to the given file (MIDI only).
---
---@param src PCM_source
---@param fn string
---@return boolean retval
function reaper.CF_ExportMediaSource(src, fn) end

---Deprecated, see kbd_getTextFromCmd (v6.71+). Wrapper for the unexposed kbd_getTextFromCmd API function. See CF_EnumerateActions for common section IDs.
---@param section integer
---@param command integer
---@return string str
function reaper.CF_GetCommandText(section, command) end

---Return a handle to the currently focused FX chain window.
---
---@return FxChain hwnd
function reaper.CF_GetFocusedFXChain() end

---Returns the bit depth if available (0 otherwise).
---
---@param src PCM_source
---@return integer retval
function reaper.CF_GetMediaSourceBitDepth(src) end

---Returns the bit rate for WAVE (wav, aif) and streaming/variable formats (mp3, ogg, opus). REAPER v6.19 or later is required for non-WAVE formats.
---@param src PCM_source
---@return number bitrate
function reaper.CF_GetMediaSourceBitRate(src) end

---Get the value of the given metadata field (eg. DESC, ORIG, ORIGREF, DATE, TIME, UMI, CODINGHISTORY for BWF).
---@param src PCM_source
---@param name string
---@param out string
---@return boolean retval, string out
function reaper.CF_GetMediaSourceMetadata(src, name, out) end

---Returns the online/offline status of the given source.
---
---@param src PCM_source
---@return boolean retval
function reaper.CF_GetMediaSourceOnline(src) end

---Get the project associated with this source (BWF, subproject...).
---
---@param src PCM_source
---@return boolean retval, string fn
function reaper.CF_GetMediaSourceRPP(src) end

---Return the current SWS version number.
---@return string version
function reaper.CF_GetSWSVersion() end

---Return a handle to the given take FX chain window. HACK: This temporarily renames the take in order to disambiguate the take FX chain window from similarily named takes.
---@param take MediaItem_Take
---@return FxChain hwnd
function reaper.CF_GetTakeFXChain(take) end

---Return a handle to the given track FX chain window.
---@param track MediaTrack
---@return FxChain hwnd
function reaper.CF_GetTrackFXChain(track) end

---Return a handle to the given track FX chain window. Set wantInputChain to get the track's input/monitoring FX chain.
---@param project ReaProject
---@param track MediaTrack
---@param wantInputChain boolean
---@return FxChain fxchain
function reaper.CF_GetTrackFXChainEx(project, track, wantInputChain) end

---Select the given file in explorer/finder.
---@param file string
---@return boolean retval
function reaper.CF_LocateInExplorer(file) end

---Give a section source created using PCM_Source_CreateFromType("SECTION"). Offset and length are ignored if 0. Negative length to subtract from the total length of the source.
---@param section PCM_source
---@param source PCM_source
---@param offset number
---@param length number
---@param reverse boolean
---@return boolean retval
function reaper.CF_PCM_Source_SetSectionInfo(section, source, offset, length, reverse) end

---Read peak volume for channel 0 or 1. Only available when outputting to a hardware output (not through a track).
---@param preview CF_Preview
---@param channel integer
---@return boolean retval, number peakvol
function reaper.CF_Preview_GetPeak(preview, channel) end

---Supported attributes:B_LOOP seek to the beginning when reaching the end of the source
---B_PPITCH preserve pitch when changing playback rate
---D_FADEINLEN lenght in seconds of playback fade in
---D_FADEOUTLEN lenght in seconds of playback fade out
---D_LENGTH (read only) length of the source * playback rate
---D_MEASUREALIGN >0 = wait until the next bar before starting playback (note: this causes playback to silently continue when project is paused and previewing through a track)
---D_PAN playback pan
---D_PITCH pitch adjustment in semitones
---D_PLAYRATE playback rate
---D_POSITION current playback position
---D_VOLUME playback volume
---I_OUTCHAN first hardware output channel (&1024=mono, reads -1 when playing through a track, see CF_Preview_SetOutputTrack)
---I_PITCHMODE highest 16 bits=pitch shift mode (see EnumPitchShiftModes), lower 16 bits=pitch shift submode (see EnumPitchShiftSubModes)
---@param preview CF_Preview
---@param name string
---@return boolean retval, number value
function reaper.CF_Preview_GetValue(preview, name) end

---Start playback of the configured preview object.
---@param preview CF_Preview
---@return boolean retval
function reaper.CF_Preview_Play(preview) end

---@param preview CF_Preview
---@param project ReaProject
---@param track MediaTrack
---@return boolean retval
function reaper.CF_Preview_SetOutputTrack(preview, project, track) end

---See CF_Preview_GetValue.
---@param preview CF_Preview
---@param name string
---@param newValue number
---@return boolean retval
function reaper.CF_Preview_SetValue(preview, name, newValue) end

---Stop and destroy a preview object.
---@param preview CF_Preview
---@return boolean retval
function reaper.CF_Preview_Stop(preview) end

---Stop and destroy all currently active preview objects.
function reaper.CF_Preview_StopAll() end

---Set which track effect is active in the track's FX chain. The FX chain window does not have to be open.
---
---@param track MediaTrack
---@param index integer
---@return boolean retval
function reaper.CF_SelectTrackFX(track, index) end

---Set the online/offline status of the given source (closes files when set=false).
---
---@param src PCM_source
---@param set boolean
function reaper.CF_SetMediaSourceOnline(src, set) end

---Open the given file or URL in the default application. See also [CF\_LocateInExplorer](#CF_LocateInExplorer).
---
---@param file string
---@return boolean retval
function reaper.CF_ShellExecute(file) end

---This function combines all other NF\_Peak/RMS functions in a single one and additionally returns peak RMS positions.  [Lua example code here](https://forum.cockos.com/showpost.php?p=2050961&postcount=6). Note: It's recommended to use this function with ReaScript/Lua as it provides reaper.array objects. 
---If using this function with other scripting languages, you must provide arrays in the [reaper.array format](https://forum.cockos.com/showpost.php?p=2039829&postcount=2).
---
---@param item MediaItem
---@param windowSize number
---@param reaper.array_peaks identifier
---@param reaper.array_peakpositions identifier
---@param reaper.array_RMSs identifier
---@param reaper.array_RMSpositions identifier
---@return boolean retval
function reaper.NF_AnalyzeMediaItemPeakAndRMS(item, windowSize, reaper.array_peaks, reaper.array_peakpositions, reaper.array_RMSs, reaper.array_RMSpositions) end

---See [NF\_GetMediaItemMaxPeak](#NF_GetMediaItemMaxPeak), additionally returns maxPeakPos (relative to item position).
---
---@param item MediaItem
---@return number retval, number maxPeakPos
function reaper.NF_GetMediaItemMaxPeakAndMaxPeakPos(item) end

---Returns SWS/S&M marker/region subtitle. markerRegionIdx: Refers to index that can be passed to [EnumProjectMarkers](#EnumProjectMarkers) (not displayed marker/region index).  
---Returns empty string if marker/region with specified index not found or marker/region subtitle not set.  [Lua code example can be found here](https://github.com/ReaTeam/ReaScripts-Templates/blob/master/Markers%20and%20Regions/NF_Get%20SWS%20markers%20and%20regions%20notes.lua)
---@param markerRegionIdx integer
---@return string subtitle
function reaper.NF_GetSWSMarkerRegionSub(markerRegionIdx) end

---Get the SWS tracknotes.
---@param track MediaTrack
---@return string tracknotes
function reaper.NF_GetSWSTrackNotes(track) end

---Get SWS analysis/normalize options. See [NF\_SetSWS\_RMSoptions](#NF_SetSWS_RMSoptions).
---@return number target, number windowSize
function reaper.NF_GetSWS_RMSoptions() end

---Set SWS/S&M marker/region subtitle. markerRegionIdx: Refers to index that can be passed to [EnumProjectMarkers](#EnumProjectMarkers)(not displayed marker/region index).  
---Returns true if subtitle is set successfully (i.e. marker/region with specified index is present in project). [Lua code example can be found here](https://github.com/ReaTeam/ReaScripts-Templates/blob/master/Markers%20and%20Regions/NF_Get%20SWS%20markers%20and%20regions%20notes.lua")
---@param markerRegionSub string
---@param markerRegionIdx integer
---@return boolean retval
function reaper.NF_SetSWSMarkerRegionSub(markerRegionSub, markerRegionIdx) end

---@param track MediaTrack
---@param str string
function reaper.NF_SetSWSTrackNotes(track, str) end

---Set SWS analysis/normalize options (same as running action 'SWS: Set RMS analysis/normalize options'). targetLevel: target RMS normalize level (dB), windowSize: window size for peak RMS (sec.)See [NF\_GetSWS\_RMSoptions](#NF_GetSWS_RMSoptions).
---@param targetLevel number
---@param windowSize number
---@return boolean retval
function reaper.NF_SetSWS_RMSoptions(targetLevel, windowSize) end

---Deprecated.
---Retrieves the name of the module of a takefx from a MediaItem.See [BR\_TrackFX\_GetFXModuleName](#BR_TrackFX_GetFXModuleName). fx: counted consecutively across all takes (zero-based).
---@param item MediaItem
---@param fx integer
---@return boolean retval, string name
function reaper.NF_TakeFX_GetModuleName(item, fx) end

---Redraw the Notes window (call if you've changed a subtitle via [NF\_SetSWSMarkerRegionSub](#NF_SetSWSMarkerRegionSub) which is currently displayed in the Notes window and you want to appear the new subtitle immediately.)
function reaper.NF_UpdateSWSMarkerRegionSubWindow() end

---Equivalent to win32 API GetSystemMetrics(). Note: Only SM_C[XY]SCREEN, SM_C[XY][HV]SCROLL and SM_CYMENU are currently supported on macOS and Linux as of REAPER 6.68. Check the SWELL source code for up-to-date support information (swell-wnd.mm, swell-wnd-generic.cpp).see: https://docs.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-getsystemmetrics.
---@param nIndex integer
---@return integer retval
function reaper.NF_Win32_GetSystemMetrics(nIndex) end
































































































































---Adds code to be executed when the script finishes or is ended by the user. Typically used to clean up after the user terminates defer() or runloop() code.You can't defer this atexit-function, when it is run as exit-function, though, when it is run regularily before exiting the script.You can define more than one atexit-function. They will be run in the order they've been registered as atexit-functions.
---For example:    reaper.atexit(exit1)
---    reaper.atexit(exit2)
---    reaper.atexit(exit3)will run exit1, exit2 and then exit3, when exiting the script.You can have up to 1024 atexit-functions set in one script, no matter if its different or the same function.
---@param function_ function
function reaper.atexit(function_) end

---Adds code to be called back by REAPER. Used to create persistent ReaScripts that continue to run and respond to input, while the user does other tasks. Identical to runloop().Note that no undo point will be automatically created when the script finishes, unless you create it explicitly.There can be 1024 defer-nodes running at the same time in one script, no matter if it's different functions or the same one.
---@param function_ function
---@return boolean retval
function reaper.defer(function_) end

---Returns contextual information about the script, typically MIDI/OSC input values.val will be set to a relative or absolute value depending on mode (=0: absolute mode, >0: relative modes). resolution=127 for 7-bit resolution, =16383 for 14-bit resolution.Notes: sectionID, and cmdID will be set to -1 if the script is not part of the action list. mode, resolution and val will be set to -1 if the script was not triggered via MIDI/OSC.For relative mode bindings, calling get_action_context() will return the accumulated relative value in decoded form (not 65 or 63, but +1/-1 etc), and clear the internal state. So if you call it multiple times, the first one will return the accumulated value, and the second will always return 0.contextstr may be empty or one of:
---  midi:XX[:YY] (one or two bytes hex)
---  [wheel|hwheel|mtvert|mthorz|mtzoom|mtrot|mediakbd]:flags
---  key:flags:keycode
---  osc:/msg[:f=FloatValue|:s=StringValue]
---  KBD_OnMainActionEx
---  (flags may include V=virtkey, S=shift, A=alt/option, C=control/command, W=win/control)
---@return boolean is_new_value, string filename_with_path, integer sectionID, integer cmdID, integer mode, integer resolution, integer val, string contextstr
function reaper.get_action_context() end

---The following global variables are special and will be used by the graphics system:  * gfx.r - current red component (0..1) used by drawing operations.
---  * gfx.g - current green component (0..1) used by drawing operations.
---  * gfx.b - current blue component (0..1) used by drawing operations.
---  * gfx.a2 - current alpha component (0..1) used by drawing operations when writing solid colors (normally ignored but useful when creating transparent images).
---  * gfx.a - alpha for drawing (1=normal).
---  * gfx.mode - blend mode for drawing. Set mode to 0 for default options. Add 1.0 for additive blend mode (if you wish to do subtractive, set gfx.a to negative and use gfx.mode as additive). Add 2.0 to disable source alpha for gfx.blit(). Add 4.0 to disable filtering for gfx.blit().
---  * gfx.w - width of the UI framebuffer.
---  * gfx.h - height of the UI framebuffer.
---  * gfx.x - current graphics position X. Some drawing functions use as start position and update.
---  * gfx.y - current graphics position Y. Some drawing functions use as start position and update.
---  * gfx.clear - if greater than -1.0, framebuffer will be cleared to that color. the color for this one is packed RGB (0..255), i.e. red+green*256+blue*65536. The default is 0 (black).
---  * gfx.dest - destination for drawing operations, -1 is main framebuffer, set to 0..1024-1 to have drawing operations go to an offscreen buffer (or loaded image).
---  * gfx.texth - the (READ-ONLY) height of a line of text in the current font. Do not modify this variable.
---  * gfx.ext_retina - to support hidpi/retina, callers should set to 1.0 on initialization, this value will be updated to value greater than 1.0 (such as 2.0) if retina/hidpi. On macOS gfx.w/gfx.h/etc will be doubled, but on other systems gfx.w/gfx.h will remain the same and gfx.ext_retina is a scaling hint for drawing.
---  * gfx.mouse_x - current X coordinate of the mouse relative to the graphics window.
---  * gfx.mouse_y - current Y coordinate of the mouse relative to the graphics window.
---  * gfx.mouse_wheel - wheel position, will change typically by 120 or a multiple thereof, the caller should clear the state to 0 after reading it.
---  * gfx.mouse_hwheel - horizontal wheel positions, will change typically by 120 or a multiple thereof, the caller should clear the state to 0 after reading it.
---  * gfx.mouse_cap - a bitfield of mouse and keyboard modifier state:
---        1: left mouse button
---        2: right mouse button
---        4: Control key
---        8: Shift key
---        16: Alt key
---        32: Windows key
---        64: middle mouse button
---        
---Note: Mousebuttons will be returned after gfx_init(), the other keyboard-modifier only when using gfx_getchar()!
---        
---@return gfx 
function VARIABLES() end

---Draws an arc of the circle centered at x,y, with ang1/ang2 being specified in radians.
---@param x integer
---@param y integer
---@param r integer
---@param ang1 number
---@param ang2 number
---@param antialias? number
function gfx.arc(x, y, r, ang1, ang2, antialias) end

---Blits(draws) the content of source-image to another source-image or an opened window.Copies from source (-1 = main framebuffer, or an image from gfx.loadimg() etc), using current opacity and copy mode (set with gfx.a, gfx.mode).If destx/desty are not specified, gfx.x/gfx.y will be used as the destination position.scale (1.0 is unscaled) will be used only if destw/desth are not specified.rotation is an angle in radianssrcx/srcy/srcw/srch specify the source rectangle (if omitted srcw/srch default to image size)destx/desty/destw/desth specify destination rectangle (if not specified destw/desth default to srcw/srch * scale).
---@param source integer
---@param scale number
---@param rotation number
---@param srcx? number
---@param srcy? number
---@param srcw? number
---@param srch? number
---@param destx? integer
---@param desty? integer
---@param destw? integer
---@param desth? integer
---@param rotxoffs? integer
---@param rotyoffs? integer
---@return integer source
function gfx.blit(source, scale, rotation, srcx, srcy, srcw, srch, destx, desty, destw, desth, rotxoffs, rotyoffs) end

---Deprecated, use gfx.blit instead.Note: the naming of the function might be misleading, as it has nothing to do with blitting of text, but rather is called Blit Ext.
---@param nil source
---@param nil coordinatelist
---@param nil rotation
---@return number retval
function gfx.blitext() end

---Blurs the region of the screen between gfx.x,gfx.y and x,y, and updates gfx.x,gfx.y to x,y.
---@param x integer
---@param y integer
function gfx.blurto(x, y) end

---Draws a circle, optionally filling/antialiasing. 
---@param x integer
---@param y integer
---@param r integer
---@param fill? number
---@param antialias? number
function gfx.circle(x, y, r, fill, antialias) end

---Converts the coordinates x,y to screen coordinates, returns those values.
---@param x integer
---@param y integer
---@return int convx, int convy
function gfx.clienttoscreen(x, y) end

---Blits from srcimg(srcs,srct,srcw,srch) to destination (destx,desty,destw,desth). Source texture coordinates are s/t, dsdx represents the change in s coordinate for each x pixel, dtdy represents the change in t coordinate for each y pixel, etc. dsdxdy represents the change in dsdx for each line. If usecliprect is specified and 0, then srcw/srch are ignored.This function allows you to manipulate the image, which you want to blit, by transforming, moving or cropping it.To do rotation, you can manipulate dtdx and dsdy together.
---@param srcimg integer
---@param srcs integer
---@param srct integer
---@param srcw integer
---@param srch integer
---@param destx number
---@param desty number
---@param destw number
---@param desth number
---@param dsdx number
---@param dtdx number
---@param dsdy number
---@param dtdy number
---@param dsdxdy number
---@param dtdxdy number
---@param usecliprect? integer
---@return number retval
function gfx.deltablit(srcimg, srcs, srct, srcw, srch, destx, desty, destw, desth, dsdx, dtdx, dsdy, dtdy, dsdxdy, dtdxdy, usecliprect) end

---Queries or sets the docking-state of the gfx.init()-window.
---Call with v=-1 to query docked state, otherwise v>=0 to set docked state. 
---State is &1 if docked, second byte is docker index (or last docker index if undocked). If you pass numbers to wx-wh, you can query window size and position additionally to the dock-stateA specific docking index does not necessarily represent a specific docker, means, you can not query/set left docker top, but rather all dockers that exist in the current screenset.
---So the first queried/set docker can be top-left-docker or the top docker or even one of the bottom dockers.
---The order doesn't seem to make any sense. Especially with more than 16 windows docked in the current screenset.
---@param v integer
---@param wx? integer
---@param wy? integer
---@param ww? integer
---@param wh? integer
---@return number querystate, integer|nil window_x_position, integer|nil window_y_position, integer|nil window_width, integer|nil window_height
function gfx.dock(v, wx, wy, ww, wh) end

---Draws the character (can be a numeric ASCII code as well), to gfx.x, gfx.y, and moves gfx.x over by the size of the character.
---@param char integer
---@return integer char
function gfx.drawchar(char) end

---Draws the number n with ndigits of precision to gfx.x, gfx.y, and updates gfx.x to the right side of the drawing. The text height is gfx.texth.
---@param n number
---@param ndigits integer
function gfx.drawnumber(n, ndigits) end

---Draws a string at gfx.x, gfx.y, and updates gfx.x/gfx.y so that subsequent draws will occur in a similar place.You can optionally set a clipping area for the text, if you set parameter flags&256 and the parameters right and bottom.On Windows, fonts with a size > 255 may have trouble of being displayed correctly, due problems with the font-rendering and the alpha-channel. <a href="https://forum.cockos.com/showpost.php?p=2311977&postcount=7">Justin's post about this.</a>
---To overcome this, try this to disable the alpha-channel: 
---By default, gfx.blit() blits with alpha channel. You can disable this behavior by setting "gfx.mode=2" before calling gfx.blit().
---@param str string
---@param flags? integer
---@param right? integer
---@param bottom? integer
function gfx.drawstr(str, flags, right, bottom) end

---If char is 0 or omitted, returns a character from the keyboard queue, or 0 if no character is available, or -1 if the graphics window is not open. If char is specified and nonzero, that character's status will be checked, and the function will return greater than 0 if it is pressed.
---Common values are standard ASCII, such as 'a', 'A', '=' and '1', but for many keys multi-byte values are used, 
---including 'home', 'up', 'down', 'left', 'right', 'f1'.. 'f12', 'pgup', 'pgdn', 'ins', and 'del'. Shortcuts with scope "Global + textfields" will still run the associated action, scope of "Normal" or "Global" will not.Modified and special keys can also be returned, including:  - Ctrl/Cmd+A..Ctrl+Z as 1..26  
---- Ctrl/Cmd+Alt+A..Z as 257..282  
---- Alt+A..Z as 'A'+256..'Z'+256  
---- 27 for ESC  
---- 13 for Enter  
---- ' ' for space  
----
---- use 65536 as parameter charactercode to query special flags, returns: &1 (supported in this script), &2=window has focus, &4=window is visible  If the user typed in multiple characters, the character queue will hold them. So calling gfx.getchar multiple times, until it returns 0 or -1 will give you all typed keys.Typed characters between 256 and 1024(maybe higher?) seem to hint at multibyte-unicode characters. 
---That means, you need to take the next character-value in the character-queue into consideration as well to get the current unicode-character!If unichar is specified, it will be set to the unicode value of the key if available (and the return value may be the unicode value or a raw key value as described above, depending). If unichar is not specified, unicode codepoints greater than 255 will be returned as 'u'<<24 + valueNote that calling gfx.getchar() at least once causes gfx.mouse_cap to reflect keyboard modifiers even when the mouse is not captured.
---
---@param character? integer
---@param unicode_char? integer
---@return integer charactercode
function gfx.getchar(character, unicode_char) end

---Returns filenames, drag'n'dropped into a window created by gfx.init().
---Use idx to get a specific filename, that has been dropped into the gfx.init()-window.When returned filename starts with @fx: it is an fx dropped.
---      
---Does NOT support mediaitems/takes or other Reaper-objects!It MUST be called BEFORE calling gfx.update, as gfx.update flushes the filelist accessible with gfx.getdropfile.
---@param idx integer
---@return integer retval, string filename
function gfx.getdropfile(idx) end

---Returns current font index, and the actual font face used by this font (if available).Use gfx.setfont to set a font for a specific index.
---@return integer fontindex, string fontface
function gfx.getfont() end

---Retrieves the dimensions of an image specified by handle, returns w, h pair.
---Handle is basically a frame-buffer.
---@param handle integer
---@return integer w, integer h
function gfx.getimgdim(handle) end

---Returns r,g,b values [0..1] of the pixel at (gfx.x,gfx.y)
---@return integer r, integer g, integer b
function gfx.getpixel() end

---Fills a gradient rectangle with the color and alpha specified. drdx-dadx reflect the adjustment (per-pixel) applied for each pixel moved to the right, drdy-dady are the adjustment applied for each pixel moved toward the bottom. Normally drdx=adjustamount/w, drdy=adjustamount/h, etc.
---@param x number
---@param y number
---@param w number
---@param h number
---@param r number
---@param g number
---@param b number
---@param a[ number
---@param drdx? number
---@param dgdx? number
---@param dbdx? number
---@param dadx? number
---@param drdy? number
---@param dgdy? number
---@param dbdy? number
---@param dady]? number
function gfx.gradrect(x, y, w, h, r, g, b, a[, drdx, dgdx, dbdx, dadx, drdy, dgdy, dbdy, dady]) end

---Initializes the graphics window with title name. Suggested width and height can be specified.Once the graphics window is open, gfx.update() should be called periodically. Only one graphics-window can be opened per script! Calling gfx.ini after a window has been opened has no effect.To resize/reposition the window, call gfx.init again and pass an empty string as name-parameter.To retitle the window, run gfx.init again with the new title as parameter name.To get the current window-states, dimensions, etc, you can use gfx.dock).
---@param "name" string
---@param width? integer
---@param height? integer
---@param dockstate? integer
---@param xpos? integer
---@param ypos? integer
---@return integer retval
function gfx.init("name", width, height, dockstate, xpos, ypos) end

---Draws a line from x,y to x2,y2, and if aa is not specified or 0.5 or greater, it will be antialiased. 
---@param x integer
---@param y integer
---@param x2 integer
---@param y2 integer
---@param aa? number
function gfx.line(x, y, x2, y2, aa) end

---Draws a line from gfx.x,gfx.y to x,y. If aa is 0.5 or greater, then antialiasing is used. Updates gfx.x and gfx.y to x,y.
---@param x integer
---@param y integer
---@param aa number
function gfx.lineto(x, y, aa) end

---Load image from filename into slot 0..1024-1 specified by image. Returns the image index if success, otherwise -1 if failure. The image will be resized to the dimensions of the image file. 
---@param image integer
---@param filename string
---@return integer retval
function gfx.loadimg(image, filename) end

---Measures the drawing dimensions of a character with the current font (as set by gfx.setfont). Returns width and height of character.
---@param char integer
---@return integer width, integer height
function gfx.measurechar(char) end

---Measures the drawing dimensions of a string with the current font (as set by gfx.setfont). Returns width and height of string.
---@param str string
---@return integer width, integer height
function gfx.measurestr(str) end

---Multiplies each pixel within the given rectangle(x,y,w,h) by the mul_*-parameters and optionally adds add_*-parameters, and updates in-place. Useful for changing brightness/contrast, or other effects.The multiplied values usually affect only pixels, that are not black(0,0,0,0), while the added values affect all pixels.
---@param x integer
---@param y integer
---@param w integer
---@param h integer
---@param mul_r number
---@param mul_g number
---@param mul_b number
---@param mul_a? number
---@param add_r? number
---@param add_g? number
---@param add_b? number
---@param add_a? number
---@return integer retval
function gfx.muladdrect(x, y, w, h, mul_r, mul_g, mul_b, mul_a, add_r, add_g, add_b, add_a) end

---Formats and draws a string at gfx.x, gfx.y, and updates gfx.x/gfx.y accordingly (the latter only if the formatted string contains newline). For more information on format strings, see sprintf()    * %% = %
---    * %s = string from parameter
---    * %d = parameter as integer
---    * %i = parameter as integer
---    * %u = parameter as unsigned integer
---    * %x = parameter as hex (lowercase) integer
---    * %X = parameter as hex (uppercase) integer
---    * %c = parameter as character
---    * %f = parameter as floating point
---    * %e = parameter as floating point (scientific notation, lowercase)
---    * %E = parameter as floating point (scientific notation, uppercase)
---    * %g = parameter as floating point (shortest representation, lowercase)
---    * %G = parameter as floating point (shortest representation, uppercase)Many standard C printf() modifiers can be used, including:    * %.10s = string, but only print up to 10 characters
---    * %-10s = string, left justified to 10 characters
---    * %10s = string, right justified to 10 characters
---    * %+f = floating point, always show sign
---    * %.4f = floating point, minimum of 4 digits after decimal point
---    * %10d = integer, minimum of 10 digits (space padded)
---    * %010f = integer, minimum of 10 digits (zero padded)Values for format specifiers can be specified as additional parameters to gfx.printf, or within {} in the format specifier (such as %{varname}d, in that case a global variable is always used).
---@param format[ string
---@param ...] various
---@return number retval
function gfx.printf(format[, ...]) end

---Closes the graphics window.
---@return integer retval
function gfx.quit() end

---Fills a rectangle at x,y, w,h pixels in dimension, filled by default. 
---@param x integer
---@param y integer
---@param w integer
---@param h integer
---@param filled? integer
---@return integer retval
function gfx.rect(x, y, w, h, filled) end

---Fills a rectangle from gfx.x,gfx.y to x,y. Updates gfx.x,gfx.y to x,y. 
---@param x integer
---@param y integer
---@return integer x_coordinate
function gfx.rectto(x, y) end

---Draws a rectangle with rounded corners. 
---@param x integer
---@param y integer
---@param w integer
---@param h integer
---@param radius number
---@param antialias? integer
---@return integer retval
function gfx.roundrect(x, y, w, h, radius, antialias) end

---Converts the screen coordinates x,y to client coordinates, returns those values.
---@param x integer
---@param y integer
---@return integer convx, integer convy
function gfx.screentoclient(x, y) end

---Sets color, drawing mode and optionally the drawing-image-source-destination.
---If sets the corresponding gfx-variables.
---Sets gfx.r/gfx.g/gfx.b/gfx.a2/gfx.mode sets gfx.dest if final parameter specified
---@param r number
---@param g? number
---@param b? number
---@param a2? number
---@param mode? integer
---@param dest? integer
---@return integer retval
function gfx.set(r, g, b, a2, mode, dest) end

---Sets the mouse cursor. resource_id is a value like 32512 (for an arrow cursor), custom_cursor_name is a string like "arrow" (for the REAPER custom arrow cursor). resource_id must be nonzero, but custom_cursor_name is optional.examples for resource_id:
---    101, enter text
---    102, hourglass
---    103, cross
---    104, arrow up
---    105, arrows to left up AND right down
---    106, arrows to left down AND right up
---    107, arrows to left AND right
---    108, arrows to up AND down
---    109, arrows to up, down, left and right
---    110, stop sign
---    111, arrow with hourglass
---    112, arrow with question mark
---    113, a pen
---    114, hand with index finger pointing
---    115, a square
---    116, arrow with cd
---    
---works only with gfx-window opened.
---@param resource_id? integer
---@param custom_cursor_name? string
---@return number retval
function gfx.setcursor(resource_id, custom_cursor_name) end

---Can select a font and optionally configure it. After calling gfx_setfont(), gfx_texth may be updated to reflect the new average line height.
---@param idx integer
---@param fontface? string
---@param sz? integer
---@param flags? integer
function gfx.setfont(idx, fontface, sz, flags) end

---Resize image referenced by index 0..1024-1, width and height must be 0-8192. The contents of the image will be undefined after the resize.
---@param image integer
---@param w integer
---@param h integer
---@return integer retval
function gfx.setimgdim(image, w, h) end

---Writes a pixel of r,g,b to gfx.x,gfx.y.
---@param r number
---@param g number
---@param b number
---@return integer retval
function gfx.setpixel(r, g, b) end

---Shows a popup menu at gfx_x,gfx_y. 
---str is a list of fields separated by | characters. Each field represents a menu item.
---Fields can start with special characters:# : grayed out
---! : checked
---> : this menu item shows a submenu
---< : last item in the current submenu
---& : before a character makes it underlined as the quick-access-character for this menu-itemAn empty field || will appear as a separator in the menu. Example: selection = gfx.showmenu("first item, followed by separator||!second item, checked|>third item which spawns a submenu|#first item in submenu, grayed out|>second and last item in submenu|fourth item in top menu")gfx.showmenu returns 0 if the user selected nothing from the menu, 1 if the first field is selected, etc.
---Note: It skips submenus and separators in the selection-number, so a if menu_string="Entry1||<Entry two|Entry three" will only return 1 for entry1 and 2 for Entry three but nothing for <Entry and ||.
---@param menu_string string
---@return integer selection
function gfx.showmenu(menu_string) end

---Blits to destination at (destx,desty), size (destw,desth). div_w and div_h should be 2..64, and table should point to a table of 2*div_w*div_h values (table can be a regular table or (for less overhead) a reaper.array). Each pair in the table represents a S,T coordinate in the source image, and the table is treated as a left-right, top-bottom list of texture coordinates, which will then be rendered to the destination.
---
---@param srcimg integer
---@param destx integer
---@param desty integer
---@param destw integer
---@param desth integer
---@param div_w integer
---@param div_h integer
---@param table table
---@return number retval
function gfx.transformblit(srcimg, destx, desty, destw, desth, div_w, div_h, table) end

---Draws a filled triangle, or any convex polygon. 
---@param x1 integer
---@param y1 integer
---@param x2 integer
---@param y2 integer
---@param x3 integer
---@param y3 integer
---@param x4? [optional
---@param y4? integer
---@param nil ...
function gfx.triangle(x1, y1, x2, y2, x3, y3, x4, y4, ) end

---Causes gmem_read()/gmem_write() to read EEL2/JSFX/Video shared memory segment named by parameter. Set to empty string to detach. 6.20+: returns previous shared memory segment name.Must be called, before you can use a specific gmem-variable-index with gmem_write!
---@param sharedMemoryName string
---@return string former_attached_gmemname
function reaper.gmem_attach(sharedMemoryName) end

---Read (number) value from shared memory attached-to by gmem_attach(). index can be [0..1<<25).returns nil if not available
---@param index integer
---@return number retval
function reaper.gmem_read(index) end

---Write (number) value to shared memory attached-to by gmem_attach(). index can be [0..1<<25).Before you can write into a currently unused variable with index "index", you must call gmem_attach first!
---@param index integer
---@param value number
function reaper.gmem_write(index, value) end

---Updates the graphics display, if opened
function gfx.update() end

---Creates a new reaper.array object of maximum and initial size size, if specified, or from the size/values of a table/array. Both size and table/array can be specified, the size parameter will override the table/array size.
---@param values] [table|array
---@param size] [integer
---@return ReaperArray reaper_array
function reaper.new_array(values], size]) end

---Adds code to be called back by REAPER. Used to create persistent ReaScripts that continue to run and respond to input, while the user does other tasks. Identical to defer().Note that no undo point will be automatically created when the script finishes, unless you create it explicitly.
---@param function_ function
---@return boolean retval
function reaper.runloop(function_) end

---Sets the value of zero or more items in the array. If value not specified, 0.0 is used. offset is 1-based, if size omitted then the maximum amount available will be set.
---@param value [number|string
---@param offset integer
---@param size] integer
---@return boolean retval
function {reaper.array}.clear(value, offset, size]) end

---Convolves complex value pairs from reaper.array, starting at 1-based srcoffs, reading/writing to 1-based destoffs. size is in normal items (so it must be even)
---@param src [reaper.array
---@param srcoffs integer
---@param size integer
---@param destoffs] integer
---@return integer retval
function {reaper.array}.convolve(src, srcoffs, size, destoffs]) end

---Copies values from reaper.array or table, starting at 1-based srcoffs, writing to 1-based destoffs.
---@param src [reaper.array
---@param srcoffs integer
---@param size integer
---@param destoffs] integer
---@return integer retval
function {reaper.array}.copy(src, srcoffs, size, destoffs]) end

---Performs a forward FFT of size. size must be a power of two between 4 and 32768 inclusive. If permute is specified and true, the values will be shuffled following the FFT to be in normal order.
---@param size[ integer
---@param permute boolean
---@param offset] integer
---@return boolean retval
function {reaper.array}.fft(size[, permute, offset]) end

---Performs a forward real->complex FFT of size. size must be a power of two between 4 and 32768 inclusive. If permute is specified and true, the values will be shuffled following the FFT to be in normal order.
---@param size[ integer
---@param permute boolean
---@param offset] integer
---@return boolean retval
function {reaper.array}.fft_real(size[, permute, offset]) end

---Returns the maximum (allocated) size of the array.
---@return integer size
function {reaper.array}.get_alloc() end

---Performs a backwards FFT of size. size must be a power of two between 4 and 32768 inclusive. If permute is specified and true, the values will be shuffled before the IFFT to be in fft-order.
---@param size[ integer
---@param permute boolean
---@param offset] integer
---@return boolean retval
function {reaper.array}.ifft(size[, permute, offset]) end

---Performs a backwards complex->real FFT of size. size must be a power of two between 4 and 32768 inclusive. If permute is specified and true, the values will be shuffled before the IFFT to be in fft-order.
---@param size[ integer
---@param permute boolean
---@param offset] integer
---@return boolean retval
function {reaper.array}.ifft_real(size[, permute, offset]) end

---Multiplies values from reaper.array, starting at 1-based srcoffs, reading/writing to 1-based destoffs.
---@param src [{reaper.array}
---@param srcoffs integer
---@param size integer
---@param destoffs] number
---@return integer retvals
function {reaper.array}.multiply(src, srcoffs, size, destoffs]) end

---Resizes an array object to size. size must be [0..max_size].
---@param nil size
---@return boolean retval
function {reaper.array}.resize() end

---Returns a new table with values from items in the array. Offset is 1-based and if size is omitted all available values are used.
---@param offset [integer
---@param size] integer
---@return table new_table
function {reaper.array}.table(offset, size]) end


















































































































































---Show the about dialog of the given package entry.
---The repository index is downloaded asynchronously if the cached copy doesn't exist or is older than one week.see ReaPack_GetOwner to get this parameter
---@param entry PackageEntry
---@return boolean retval
function reaper.ReaPack_AboutInstalledPackage(entry) end

---Show the about dialog of the given repository. Returns true if the repository exists in the user configuration.
---The repository index is downloaded asynchronously if the cached copy doesn't exist or is older than one week.
---@param repoName string
---@return boolean retval
function reaper.ReaPack_AboutRepository(repoName) end

---Add or modify a repository. Set url to nullptr (or empty string in Lua) to keep the existing URL. Call ReaPack_ProcessQueue(true) when done to process the new list and update the GUI.autoInstall: usually set to 2 (obey user setting).
---@param name string
---@param url string
---@param enable boolean
---@param autoInstall integer
---@return boolean retval, string error
function reaper.ReaPack_AddSetRepository(name, url, enable, autoInstall) end

---Opens the package browser with the given filter string.
---@param filter string
function reaper.ReaPack_BrowsePackages(filter) end

---Compares two versionnumbers. Versionnumbers must start with a number/digit, or they can't be compared.
---Returns 0 if both versions are equal, a positive value if ver1 is higher than ver2 and a negative value otherwise.
---@param ver1 string
---@param ver2 string
---@return integer retval, string error
function reaper.ReaPack_CompareVersions(ver1, ver2) end

---Enumerate the files owned by the given package. Returns false when there is no more data.   sections: 0=not in action list, &1=main, &2=midi editor, &4=midi inline editor
---   type: see ReaPack_GetEntryInfo.   see ReaPack_GetOwner to get the value for the parameter entry
---
---@param entry PackageEntry
---@param index integer
---@return boolean retval, string path, integer sections, integer type
function reaper.ReaPack_EnumOwnedFiles(entry, index) end

---Free resources allocated for the given package entry. Must be used to free PackageEntry-objects created by ReaPack_GetOwner.
---@param entry PackageEntry
---@return boolean retval
function reaper.ReaPack_FreeEntry(entry) end

---Get the repository name, category, package name, package description, package type, the currently installed version, author name, flags (&1=Pinned, &2=BleedingEdge) and how many files are owned by the given package entry.see ReaPack_GetOwner to get value for parameter entry
---@param entry PackageEntry
---@return boolean retval, string repo, string cat, string pkg, string desc, integer type, string ver, string author, integer flags, integer fileCount
function reaper.ReaPack_GetEntryInfo(entry) end

---Returns the package entry owning the given file.
---Delete the returned object from memory after use with ReaPack_FreeEntry.
---@param fn string
---@return PackageEntry retval, string error
function reaper.ReaPack_GetOwner(fn) end

---Get the infos of the given repository.
---@param name string
---@return boolean retval, string url, boolean enabled, integer autoInstall
function reaper.ReaPack_GetRepositoryInfo(name) end

---Run pending operations and save the configuration file. If refreshUI is true the browser and manager windows are guaranteed to be refreshed (otherwise it depends on which operations are in the queue).
---@param refreshUI boolean
function reaper.ReaPack_ProcessQueue(refreshUI) end

---Output a message to screen readers.
---This should only be used in consultation with screen reader users. Note that this may not work on Windows when certain GUI controls have focus such as list boxes and trees.Keep it short and to the point.
---@param message string
function reaper.osara_outputMessage(message) end

---Get the value of metadata from media source(.wav only). metaType=BWF,IXML,INFO,CART, key=MetadataID(eg.INAM,IART,... of INFO)
---@param src PCM_source
---@param metaType string
---@param key string
---@param buf string
---@param bufSize integer
---@return boolean retval, string buf
function reaper.RDNA_GetMediaSourceMetadata(src, metaType, key, buf, bufSize) end

---Clears ReaFab control map, optionally based on matching idString. Returns true on success.
---@param idString? string
---@return boolean retval
function reaper.Fab_Clear(idString) end

---Runs ReaFab actions/commands. First parameter (command) is ReaFab command number, e.g. 3 for 3rd encoder rotation. Second parameter (val) is MIDI CC Relative value. Value 1 is increment of 1, 127 is decrement of 1. 2 is inc 2, 126 is dec 2 and so on. For button press (commands 9-32) a value of 127 is recommended.
---@param command integer
---@param val integer
---@return boolean retval
function reaper.Fab_Do(command, val) end

---Dumps current control mapping into .lua file under ResourcePath/Scripts/reafab_dump-timestamp.lua
function reaper.Fab_Dump() end

---Returns target FX and parameter index for given ReaFab command in context of selected track and ReaFab FX index. Valid command range 1 ... 24. Returns false if no such command mapping is found. Returns param index -1 for ReaFab internal band change command.
---@param command integer
---@return boolean retval, integer fx, integer param
function reaper.Fab_Get(command) end

---Creates control mapping for ReaFab command.
---fxId e.g. "ReaComp".
---command 1-8 for encoders, 9-24 for buttons.
---paramId e.g. "Ratio".
---control 1 = direct, 2 = band selector, 3 = cycle, 4 = invert, 5 = force toggle, 6 = force range, 7 = 5 and 6, 8 = force continuous.
---bands define, if target fx has multiple identical target bands. In this case, paramId must include 00 placeholder, e.g. "Band 00 Gain".
---step overrides built-in default step of ~0.001 for continuous parameters.
---accel overrides built-in default control acceleration step of 1.0.
---minval &amp; maxval override default detected target param value range.
---Prefixing paramId with "-" reverses direction; useful for creating separate next/previous mappings for bands or list type value navigation.
---@param fxId string
---@param command integer
---@param paramId string
---@param control integer
---@param bands? integer
---@param step? number
---@param accel? number
---@param minval? number
---@param maxval? number
---@return boolean retval
function reaper.Fab_Map(fxId, command, paramId, control, bands, step, accel, minval, maxval) end

---Accept contents of a given type. If DragDropFlags_AcceptBeforeDelivery is set
---you can peek into the payload before the mouse button is released.
---@param ctx ImGui_Context
---@param type string
---@param payload? string DOCS say this is nil
---@param flags? number
---@return boolean retval, string payload
function reaper.ImGui_AcceptDragDropPayload(ctx, type, payload, flags) end

---Accept a list of dropped files. See AcceptDragDropPayload and GetDragDropPayloadFile.
---@param ctx ImGui_Context
---@param count? integer DOCS say this is nil
---@param flags? integer
---@return boolean retval, integer count
function reaper.ImGui_AcceptDragDropPayloadFiles(ctx, count, flags) end

---Accept a RGB color. See AcceptDragDropPayload.
---@param ctx ImGui_Context
---@param rgb? integer DOCS say this is nil
---@param flags? integer
---@return boolean retval, integer rgb
function reaper.ImGui_AcceptDragDropPayloadRGB(ctx, rgb, flags) end

---Accept a RGBA color. See AcceptDragDropPayload.
---@param ctx ImGui_Context
---@param rgba? integer DOCS say this is nil
---@param flags? integer
---@return boolean retval, integer rgba
function reaper.ImGui_AcceptDragDropPayloadRGBA(ctx, rgba, flags) end

---Vertically align upcoming text baseline to StyleVar_FramePadding.y so that it
---will align properly to regularly framed items (call if you have text on a line
---before a framed item).
---@param ctx ImGui_Context
function reaper.ImGui_AlignTextToFramePadding(ctx) end

---Square button with an arrow shape. 'dir' is one of the Dir_* values
---@param ctx ImGui_Context
---@param str_id string
---@param dir integer
---@return boolean 
function reaper.ImGui_ArrowButton(ctx, str_id, dir) end

---Link the object's lifetime to the given context.
---Objects can be draw list splitters, fonts, images, list clippers, etc.
---Call Detach to let the object be garbage-collected after unuse again.List clipper objects may only be attached to the context they were created for.Fonts are (currently) a special case: they must be attached to the context
---before usage. Furthermore, fonts may only be attached or detached immediately
---after the context is created or before any other function calls modifying the
---context per defer cycle. See "limitations" in the font API documentation.
---@param ctx? ImGui_Context
---@param obj? ImGui_Font | ImGui_Image
function reaper.ImGui_Attach(ctx, obj) end

---@param ctx ImGui_Context
---@param str_id string
---@param img ImGui_Image
---@param size_w number
---@param size_h number
---@param uv0_x? number
---@param uv0_y? number
---@param uv1_x? number
---@param uv1_y? number
---@param bg_col_rgba? integer
---@param tint_col_rgba? integer
function reaper.ImGui_AttachButton(ctx, str_id, img, size_w, size_h, uv0_x, uv0_y, uv1_x, uv1_y, bg_col_rgba, tint_col_rgba)end

---TODO can’t find in docs
---Push window to the stack and start appending to it.- Passing true to 'p_open' shows a window-closing widget in the upper-right
---  corner of the window, which clicking will set the boolean to false when returned.
---- You may append multiple times to the same window during the same frame by
---  calling Begin()/End() pairs multiple times. Some information such as 'flags'
---  or 'p_open' will only be considered by the first call to Begin().
---- Begin() return false to indicate the window is collapsed or fully clipped,
---  so you may early out and omit submitting anything to the window.
---@param ctx ImGui_Context
---@param name string
---@param p_open? boolean
---@param flags? integer
---@return boolean retval, boolean|nil p_open
function reaper.ImGui_Begin(ctx, name, p_open, flags) end

---For each independent axis of 'size':
---- \&gt; 0.0: fixed size
---- = 0.0: use remaining host window size
---- &lt; 0.0: use remaining window size minus abs(size)
---(Each axis can use a different mode, e.g. size = 0x400.)Returns false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting anything to the window.
---@param ctx ImGui_Context
---@param str_id string
---@param size_w? number
---@param size_h? number
---@param border? boolean
---@param flags? integer
---@return boolean 
function reaper.ImGui_BeginChild(ctx, str_id, size_w, size_h, border, flags) end

---Helper to create a child window / scrolling region that looks like a normal
---widget frame. See BeginChild.
---@param ctx ImGui_Context
---@param str_id string
---@param size_w number
---@param size_h number
---@param flags? integer
---@return boolean 
function reaper.ImGui_BeginChildFrame(ctx, str_id, size_w, size_h, flags) end

---The BeginCombo/EndCombo API allows you to manage your contents and selection
---state however you want it, by creating e.g. Selectable items.
---@param ctx ImGui_Context
---@param label string
---@param preview_value string
---@param flags? integer
---@return boolean 
function reaper.ImGui_BeginCombo(ctx, label, preview_value, flags) end

---Disable all user interactions and dim items visuals
---(applying StyleVar_DisabledAlpha over current colors).BeginDisabled(false) essentially does nothing useful but is provided to
---facilitate use of boolean expressions.
---If you can avoid calling BeginDisabled(false)/EndDisabled() best to avoid it.
---@param ctx ImGui_Context
---@param disabled? boolean
function reaper.ImGui_BeginDisabled(ctx, disabled) end

---Call after submitting an item which may be dragged. when this return true,
---you can call SetDragDropPayload() + EndDragDropSource()If you stop calling BeginDragDropSource() the payload is preserved however
---it won't have a preview tooltip (we currently display a fallback "..." tooltip
---as replacement).
---@param ctx ImGui_Context
---@param flags? integer
---@return boolean 
function reaper.ImGui_BeginDragDropSource(ctx, flags) end

---Call after submitting an item that may receive a payload.
---If this returns true, you can call AcceptDragDropPayload + EndDragDropTarget.
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_BeginDragDropTarget(ctx) end

---Lock horizontal starting position. See EndGroup.
---@param ctx ImGui_Context
function reaper.ImGui_BeginGroup(ctx) end

---Open a framed scrolling region. This is essentially a thin wrapper to using
---BeginChild/EndChild with some stylistic changes.The BeginListBox/EndListBox API allows you to manage your contents and selection
---state however you want it, by creating e.g. Selectable or any items.- Choose frame width:
---  - width  &gt; 0.0: custom
---  - width  &lt; 0.0 or -FLT_MIN: right-align
---  - width  = 0.0 (default): use current ItemWidth
---- Choose frame height:
---  - height &gt; 0.0: custom
---  - height &lt; 0.0 or -FLT_MIN: bottom-align
---  - height = 0.0 (default): arbitrary default height which can fit ~7 itemsSee EndListBox.
---@param ctx ImGui_Context
---@param label string
---@param size_w? number
---@param size_h? number
---@return boolean 
function reaper.ImGui_BeginListBox(ctx, label, size_w, size_h) end

---Create a sub-menu entry. only call EndMenu if this returns true!
---@param ctx ImGui_Context
---@param label string
---@param enabled? boolean
---@return boolean 
function reaper.ImGui_BeginMenu(ctx, label, enabled) end

---Append to menu-bar of current window (requires WindowFlags_MenuBar flag set
---on parent window). See EndMenuBar.
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_BeginMenuBar(ctx) end

---Query popup state, if open start appending into the window. Call EndPopup
---afterwards. WindowFlags* are forwarded to the window.Return true if the popup is open, and you can start outputting to it.
---@param ctx ImGui_Context
---@param str_id string
---@param flags? integer
---@return boolean 
function reaper.ImGui_BeginPopup(ctx, str_id, flags) end

---This is a helper to handle the simplest case of associating one named popup
---to one given widget. You can pass a nil str_id to use the identifier of the last
---item. This is essentially the same as calling OpenPopupOnItemClick + BeginPopup
---but written to avoid computing the ID twice because BeginPopupContext*
---functions may be called very frequently.If you want to use that on a non-interactive item such as Text you need to pass
---in an explicit ID here.
---@param ctx ImGui_Context
---@param str_id? string
---@param popup_flags? number
---@return boolean 
function reaper.ImGui_BeginPopupContextItem(ctx, str_id, popup_flags) end

---Open+begin popup when clicked on current window.
---@param ctx ImGui_Context
---@param str_id? string
---@param popup_flags? integer
---@return boolean 
function reaper.ImGui_BeginPopupContextWindow(ctx, str_id, popup_flags) end

---Block every interaction behind the window, cannot be closed by user, add a
---dimming background, has a title bar. Return true if the modal is open, and you
---can start outputting to it. See BeginPopup.
---@param ctx ImGui_Context
---@param name string
---@param p_open? boolean
---@param flags? integer
---@return boolean retval, boolean|nil p_open
function reaper.ImGui_BeginPopupModal(ctx, name, p_open, flags) end

---Create and append into a TabBar.
---@param ctx ImGui_Context
---@param str_id string
---@param flags? integer
---@return boolean 
function reaper.ImGui_BeginTabBar(ctx, str_id, flags) end

---Create a Tab. Returns true if the Tab is selected.
---Set 'p_open' to true to enable the close button.
---@param ctx ImGui_Context
---@param label string
---@param p_open? boolean
---@param flags? integer
---@return boolean retval, boolean|nil p_open
function reaper.ImGui_BeginTabItem(ctx, label, p_open, flags) end

---@param ctx ImGui_Context
---@param str_id string
---@param column integer
---@param flags? integer
---@param outer_size_w? number
---@param outer_size_h? number
---@param inner_width? number
---@return boolean 
function reaper.ImGui_BeginTable(ctx, str_id, column, flags, outer_size_w, outer_size_h, inner_width) end

---Begin/append a tooltip window.
---To create full-featured tooltip (with any kind of items).
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_BeginTooltip(ctx) end

---Draw a small circle + keep the cursor on the same line.
---Advance cursor x position by GetTreeNodeToLabelSpacing,
---same distance that TreeNode uses.
---@param ctx ImGui_Context
function reaper.ImGui_Bullet(ctx) end

---Shortcut for Bullet + Text.
---@param ctx ImGui_Context
---@param text string
function reaper.ImGui_BulletText(ctx, text) end

---TODO can’t find in docs
---@param ctx ImGui_Context
---@param label string
---@param size_w? number
---@param size_h? number
---@return boolean 
function reaper.ImGui_Button(ctx, label, size_w, size_h) end

---React on left mouse button (default).
---@return integer retval
function reaper.ImGui_ButtonFlags_MouseButtonLeft() end

---React on center mouse button.
---@return integer retval
function reaper.ImGui_ButtonFlags_MouseButtonMiddle() end

---React on right mouse button.
---@return integer retval
function reaper.ImGui_ButtonFlags_MouseButtonRight() end

---@return integer retval
function reaper.ImGui_ButtonFlags_None() end

---Width of item given pushed settings and current cursor position.
---NOT necessarily the width of last item unlike most 'Item' functions.
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_CalcItemWidth(ctx) end

---@param ctx ImGui_Context
---@param text string
---@param w? number
---@param h? number
---@param hide_text_after_double_hash? boolean
---@param wrap_width? number
---@return number w, number h
function reaper.ImGui_CalcTextSize(ctx, text, w, h, hide_text_after_double_hash, wrap_width) end

---@param ctx ImGui_Context
---@param label string
---@param v boolean
---@return boolean retval, boolean v
function reaper.ImGui_Checkbox(ctx, label, v) end

---@param ctx ImGui_Context
---@param label string
---@param flags integer
---@param flags_value integer
---@return boolean retval, integer flags
function reaper.ImGui_CheckboxFlags(ctx, label, flags, flags_value) end

---Manually close the popup we have begin-ed into.
---Use inside the BeginPopup/EndPopup scope to close manually.CloseCurrentPopup() is called by default by Selectable/MenuItem when activated.
---@param ctx ImGui_Context
function reaper.ImGui_CloseCurrentPopup(ctx) end

---@return integer retval
function reaper.ImGui_Col_Border() end

---@return integer retval
function reaper.ImGui_Col_BorderShadow() end

---@return integer retval
function reaper.ImGui_Col_Button() end

---@return integer retval
function reaper.ImGui_Col_ButtonActive() end

---@return integer retval
function reaper.ImGui_Col_ButtonHovered() end

---@return integer retval
function reaper.ImGui_Col_CheckMark() end

---Background of child windows.
---@return integer retval
function reaper.ImGui_Col_ChildBg() end

---Background color for empty node (e.g. CentralNode with no window docked into it).
---@return integer retval
function reaper.ImGui_Col_DockingEmptyBg() end

---Preview overlay color when about to docking something.
---@return integer retval
function reaper.ImGui_Col_DockingPreview() end

---Rectangle highlighting a drop target
---@return integer retval
function reaper.ImGui_Col_DragDropTarget() end

---Background of checkbox, radio button, plot, slider, text input.
---@return integer retval
function reaper.ImGui_Col_FrameBg() end

---@return integer retval
function reaper.ImGui_Col_FrameBgActive() end

---@return integer retval
function reaper.ImGui_Col_FrameBgHovered() end

---Header* colors are used for CollapsingHeader, TreeNode, Selectable, MenuItem.
---@return integer retval
function reaper.ImGui_Col_Header() end

---@return integer retval
function reaper.ImGui_Col_HeaderActive() end

---@return integer retval
function reaper.ImGui_Col_HeaderHovered() end

---@return integer retval
function reaper.ImGui_Col_MenuBarBg() end

---Darken/colorize entire screen behind a modal window, when one is active.
---@return integer retval
function reaper.ImGui_Col_ModalWindowDimBg() end

---Gamepad/keyboard: current highlighted item.
---@return integer retval
function reaper.ImGui_Col_NavHighlight() end

---Darken/colorize entire screen behind the CTRL+TAB window list, when active.
---@return integer retval
function reaper.ImGui_Col_NavWindowingDimBg() end

---Highlight window when using CTRL+TAB.
---@return integer retval
function reaper.ImGui_Col_NavWindowingHighlight() end

---@return integer retval
function reaper.ImGui_Col_PlotHistogram() end

---@return integer retval
function reaper.ImGui_Col_PlotHistogramHovered() end

---@return integer retval
function reaper.ImGui_Col_PlotLines() end

---@return integer retval
function reaper.ImGui_Col_PlotLinesHovered() end

---Background of popups, menus, tooltips windows.
---@return integer retval
function reaper.ImGui_Col_PopupBg() end

---Resize grip in lower-right and lower-left corners of windows.
---@return integer retval
function reaper.ImGui_Col_ResizeGrip() end

---@return integer retval
function reaper.ImGui_Col_ResizeGripActive() end

---@return integer retval
function reaper.ImGui_Col_ResizeGripHovered() end

---@return integer retval
function reaper.ImGui_Col_ScrollbarBg() end

---@return integer retval
function reaper.ImGui_Col_ScrollbarGrab() end

---@return integer retval
function reaper.ImGui_Col_ScrollbarGrabActive() end

---@return integer retval
function reaper.ImGui_Col_ScrollbarGrabHovered() end

---@return integer retval
function reaper.ImGui_Col_Separator() end

---@return integer retval
function reaper.ImGui_Col_SeparatorActive() end

---@return integer retval
function reaper.ImGui_Col_SeparatorHovered() end

---@return integer retval
function reaper.ImGui_Col_SliderGrab() end

---@return integer retval
function reaper.ImGui_Col_SliderGrabActive() end

---TabItem in a TabBar
---@return integer retval
function reaper.ImGui_Col_Tab() end

---@return integer retval
function reaper.ImGui_Col_TabActive() end

---@return integer retval
function reaper.ImGui_Col_TabHovered() end

---@return integer retval
function reaper.ImGui_Col_TabUnfocused() end

---@return integer retval
function reaper.ImGui_Col_TabUnfocusedActive() end

---Table inner borders (prefer using Alpha=1.0 here).
---@return integer retval
function reaper.ImGui_Col_TableBorderLight() end

---Table outer and header borders (prefer using Alpha=1.0 here).
---@return integer retval
function reaper.ImGui_Col_TableBorderStrong() end

---Table header background.
---@return integer retval
function reaper.ImGui_Col_TableHeaderBg() end

---Table row background (even rows).
---@return integer retval
function reaper.ImGui_Col_TableRowBg() end

---Table row background (odd rows).
---@return integer retval
function reaper.ImGui_Col_TableRowBgAlt() end

---@return integer retval
function reaper.ImGui_Col_Text() end

---@return integer retval
function reaper.ImGui_Col_TextDisabled() end

---@return integer retval
function reaper.ImGui_Col_TextSelectedBg() end

---@return integer retval
function reaper.ImGui_Col_TitleBg() end

---@return integer retval
function reaper.ImGui_Col_TitleBgActive() end

---@return integer retval
function reaper.ImGui_Col_TitleBgCollapsed() end

---Background of normal windows. See also WindowFlags_NoBackground.
---@return integer retval
function reaper.ImGui_Col_WindowBg() end

---Returns true when opened but do not indent nor push into the ID stack
---(because of the TreeNodeFlags_NoTreePushOnOpen flag).This is basically the same as calling TreeNode(label, TreeNodeFlags_CollapsingHeader).
---You can remove the _NoTreePushOnOpen flag if you want behavior closer to normal
---TreeNode.When 'visible' is provided: if 'true' display an additional small close button
---on upper right of the header which will set the bool to false when clicked,
---if 'false' don't display the header.
---@param ctx ImGui_Context
---@param label string
---@param p_visible boolean
---@param flags? integer
---@return boolean retval, boolean p_visible
function reaper.ImGui_CollapsingHeader(ctx, label, p_visible, flags) end

---Display a color square/button, hover for details, return true when pressed.
---Color is in 0xRRGGBBAA or, if ColorEditFlags_NoAlpha is set, 0xRRGGBB.
---@param ctx ImGui_Context
---@param desc_id string
---@param col_rgba integer
---@param flags? integer
---@param size_w? number
---@param size_h? number
---@return boolean 
function reaper.ImGui_ColorButton(ctx, desc_id, col_rgba, flags, size_w, size_h) end

---Pack 0..1 RGBA values into a 32-bit integer (0xRRGGBBAA).
---@param r number
---@param g number
---@param b number
---@param a number
---@return integer retval
function reaper.ImGui_ColorConvertDouble4ToU32(r, g, b, a) end

---Convert HSV values (0..1) into RGB (0..1).
---@param h number
---@param s number
---@param v number
---@param a? number alpha
---@return number r, number g, number b
function reaper.ImGui_ColorConvertHSVtoRGB(h, s, v, a) end

---Convert a native color coming from REAPER or 0xRRGGBB to native.
---This swaps the red and blue channels on Windows.
---@param rgb integer
---@return integer retval
function reaper.ImGui_ColorConvertNative(rgb) end

---Convert RGB values (0..1) into HSV (0..1).
---@param r number
---@param g number
---@param b number
---@return number h, number s, number v
function reaper.ImGui_ColorConvertRGBtoHSV(r, g, b) end

---Unpack a 32-bit integer (0xRRGGBBAA) into separate RGBA values (0..1).
---@param rgba integer
---@return number r, number g, number b, number a
function reaper.ImGui_ColorConvertU32ToDouble4(rgba) end

---Color is in 0xXXRRGGBB. XX is ignored and will not be modified.
---@param ctx ImGui_Context
---@param label string
---@param col_rgb integer
---@param flags? integer
---@return boolean retval, integer col_rgb
function reaper.ImGui_ColorEdit3(ctx, label, col_rgb, flags) end

---Color is in 0xRRGGBBAA or, if ColorEditFlags_NoAlpha is set, 0xXXRRGGBB
---(XX is ignored and will not be modified).
---@param ctx ImGui_Context
---@param label string
---@param col_rgba integer
---@param flags? integer
---@return boolean retval, integer col_rgba
function reaper.ImGui_ColorEdit4(ctx, label, col_rgba, flags) end

---ColorEdit, ColorPicker: show vertical alpha bar/gradient in picker.
---@return integer retval
function reaper.ImGui_ColorEditFlags_AlphaBar() end

---ColorEdit, ColorPicker, ColorButton: display preview as a transparent color
---   over a checkerboard, instead of opaque.
---@return integer retval
function reaper.ImGui_ColorEditFlags_AlphaPreview() end

---ColorEdit, ColorPicker, ColorButton: display half opaque / half checkerboard,
---   instead of opaque.
---@return integer retval
function reaper.ImGui_ColorEditFlags_AlphaPreviewHalf() end

---ColorEdit: override _display_ type to HSV. ColorPicker:
---   select any combination using one or more of RGB/HSV/Hex.
---@return integer retval
function reaper.ImGui_ColorEditFlags_DisplayHSV() end

---ColorEdit: override _display_ type to Hex. ColorPicker:
---   select any combination using one or more of RGB/HSV/Hex.
---@return integer retval
function reaper.ImGui_ColorEditFlags_DisplayHex() end

---ColorEdit: override _display_ type to RGB. ColorPicker:
---   select any combination using one or more of RGB/HSV/Hex.
---@return integer retval
function reaper.ImGui_ColorEditFlags_DisplayRGB() end

---ColorEdit, ColorPicker, ColorButton: _display_ values formatted as 0.0..1.0
---   floats instead of 0..255 integers. No round-trip of value via integers.
---@return integer retval
function reaper.ImGui_ColorEditFlags_Float() end

---ColorEdit, ColorPicker: input and output data in HSV format.
---@return integer retval
function reaper.ImGui_ColorEditFlags_InputHSV() end

---ColorEdit, ColorPicker: input and output data in RGB format.
---@return integer retval
function reaper.ImGui_ColorEditFlags_InputRGB() end

---ColorEdit, ColorPicker, ColorButton: ignore Alpha component
---  (will only read 3 components from the input pointer).
---@return integer retval
function reaper.ImGui_ColorEditFlags_NoAlpha() end

---ColorButton: disable border (which is enforced by default).
---@return integer retval
function reaper.ImGui_ColorEditFlags_NoBorder() end

---ColorEdit: disable drag and drop target. ColorButton: disable drag and drop source.
---@return integer retval
function reaper.ImGui_ColorEditFlags_NoDragDrop() end

---ColorEdit, ColorPicker: disable inputs sliders/text widgets
---   (e.g. to show only the small preview color square).
---@return integer retval
function reaper.ImGui_ColorEditFlags_NoInputs() end

---ColorEdit, ColorPicker: disable display of inline text label
---   (the label is still forwarded to the tooltip and picker).
---@return integer retval
function reaper.ImGui_ColorEditFlags_NoLabel() end

---ColorEdit: disable toggling options menu when right-clicking on inputs/small preview.
---@return integer retval
function reaper.ImGui_ColorEditFlags_NoOptions() end

---ColorEdit: disable picker when clicking on color square.
---@return integer retval
function reaper.ImGui_ColorEditFlags_NoPicker() end

---ColorPicker: disable bigger color preview on right side of the picker,
---   use small color square preview instead.
---@return integer retval
function reaper.ImGui_ColorEditFlags_NoSidePreview() end

---ColorEdit, ColorPicker: disable color square preview next to the inputs.
---   (e.g. to show only the inputs).
---@return integer retval
function reaper.ImGui_ColorEditFlags_NoSmallPreview() end

---ColorEdit, ColorPicker, ColorButton: disable tooltip when hovering the preview.
---@return integer retval
function reaper.ImGui_ColorEditFlags_NoTooltip() end

---@return integer retval
function reaper.ImGui_ColorEditFlags_None() end

---ColorPicker: bar for Hue, rectangle for Sat/Value.
---@return integer retval
function reaper.ImGui_ColorEditFlags_PickerHueBar() end

---ColorPicker: wheel for Hue, triangle for Sat/Value.
---@return integer retval
function reaper.ImGui_ColorEditFlags_PickerHueWheel() end

---ColorEdit, ColorPicker, ColorButton: _display_ values formatted as 0..255.
---@return integer retval
function reaper.ImGui_ColorEditFlags_Uint8() end

---Color is in 0xXXRRGGBB. XX is ignored and will not be modified.
---@param ctx ImGui_Context
---@param label string
---@param col_rgb integer
---@param flags? integer
---@return boolean retval, integer col_rgb
function reaper.ImGui_ColorPicker3(ctx, label, col_rgb, flags) end

---@param ctx ImGui_Context
---@param label string
---@param col_rgba integer
---@param flags? integer
---@param ref_col? integer
---@return boolean retval, integer col_rgba
function reaper.ImGui_ColorPicker4(ctx, label, col_rgba, flags, ref_col) end

---Helper over BeginCombo/EndCombo for convenience purpose. Each item must be
---null-terminated (requires REAPER v6.44 or newer for EEL and Lua).
---@param ctx ImGui_Context
---@param label string
---@param current_item integer
---@param items string
---@param popup_max_height_in_items? integer
---@return boolean retval, integer current_item
function reaper.ImGui_Combo(ctx, label, current_item, items, popup_max_height_in_items) end

---Max ~20 items visible.
---@return integer retval
function reaper.ImGui_ComboFlags_HeightLarge() end

---As many fitting items as possible.
---@return integer retval
function reaper.ImGui_ComboFlags_HeightLargest() end

---Max ~8 items visible (default).
---@return integer retval
function reaper.ImGui_ComboFlags_HeightRegular() end

---Max ~4 items visible. Tip: If you want your combo popup to be a specific size
---you can use SetNextWindowSizeConstraints prior to calling BeginCombo.
---@return integer retval
function reaper.ImGui_ComboFlags_HeightSmall() end

---Display on the preview box without the square arrow button.
---@return integer retval
function reaper.ImGui_ComboFlags_NoArrowButton() end

---Display only a square arrow button.
---@return integer retval
function reaper.ImGui_ComboFlags_NoPreview() end

---@return integer retval
function reaper.ImGui_ComboFlags_None() end

---Align the popup toward the left by default.
---@return integer retval
function reaper.ImGui_ComboFlags_PopupAlignLeft() end

---No condition (always set the variable).
---@return integer retval
function reaper.ImGui_Cond_Always() end

---Set the variable if the object/window is appearing after being
---   hidden/inactive (or the first time).
---@return integer retval
function reaper.ImGui_Cond_Appearing() end

---Set the variable if the object/window has no persistently saved data
---   (no entry in .ini file).
---@return integer retval
function reaper.ImGui_Cond_FirstUseEver() end

---Set the variable once per runtime session (only the first call will succeed).
---@return integer retval
function reaper.ImGui_Cond_Once() end

---[BETA] Enable docking functionality.
---@return integer retval
function reaper.ImGui_ConfigFlags_DockingEnable() end

---Master keyboard navigation enable flag.
---Enable full Tabbing + directional arrows + space/enter to activate.
---@return integer retval
function reaper.ImGui_ConfigFlags_NavEnableKeyboard() end

---Instruct navigation to move the mouse cursor.
---@return integer retval
function reaper.ImGui_ConfigFlags_NavEnableSetMousePos() end

---Instruct navigation to not capture global keyboard input when
---   ConfigFlags_NavEnableKeyboard is set (see SetNextFrameWantCaptureKeyboard).
---@return integer retval
function reaper.ImGui_ConfigFlags_NavNoCaptureKeyboard() end

---Instruct imgui to ignore mouse position/buttons.
---@return integer retval
function reaper.ImGui_ConfigFlags_NoMouse() end

---Instruct backend to not alter mouse cursor shape and visibility.
---@return integer retval
function reaper.ImGui_ConfigFlags_NoMouseCursorChange() end

---Disable state restoration and persistence for the whole context.
---@return integer retval
function reaper.ImGui_ConfigFlags_NoSavedSettings() end

---@return integer retval
function reaper.ImGui_ConfigFlags_None() end

---Some calls to Begin()/BeginChild() will return false.
---Will cycle through window depths then repeat. Suggested use: add
---"SetConfigVar(ConfigVar_DebugBeginReturnValueLoop(), GetKeyMods() == Mod_Shift"
---in your main loop then occasionally press SHIFT.
---Windows should be flickering while running.
---@return integer retval
function reaper.ImGui_ConfigVar_DebugBeginReturnValueLoop() end

---First-time calls to Begin()/BeginChild() will return false.
---**Needs to be set at context startup time** if you don't want to miss windows.
---@return integer retval
function reaper.ImGui_ConfigVar_DebugBeginReturnValueOnce() end

---Simplified docking mode: disable window splitting, so docking is limited to
---   merging multiple windows together into tab-bars.
---@return integer retval
function reaper.ImGui_ConfigVar_DockingNoSplit() end

---Make window or viewport transparent when docking and only display docking
---   boxes on the target viewport.
---@return integer retval
function reaper.ImGui_ConfigVar_DockingTransparentPayload() end

---Enable docking with holding Shift key
---   (reduce visual noise, allows dropping in wider space
---@return integer retval
function reaper.ImGui_ConfigVar_DockingWithShift() end

---Enable turning Drag* widgets into text input with a simple mouse
---   click-release (without moving). Not desirable on devices without a keyboard.
---@return integer retval
function reaper.ImGui_ConfigVar_DragClickToInputText() end

---ConfigFlags_*
---@return integer retval
function reaper.ImGui_ConfigVar_Flags() end

---Delay on hovering before IsItemHovered(HoveredFlags_DelayNormal) returns true.
---@return integer retval
function reaper.ImGui_ConfigVar_HoverDelayNormal() end

---Delay on hovering before IsItemHovered(HoveredFlags_DelayShort) returns true.
---@return integer retval
function reaper.ImGui_ConfigVar_HoverDelayShort() end

---Enable blinking cursor (optional as some users consider it to be distracting).
---@return integer retval
function reaper.ImGui_ConfigVar_InputTextCursorBlink() end

---Pressing Enter will keep item active and select contents (single-line only).
---@return integer retval
function reaper.ImGui_ConfigVar_InputTextEnterKeepActive() end

---Enable input queue trickling: some types of events submitted during the same
---   frame (e.g. button down + up) will be spread over multiple frames, improving
---   interactions with low framerates.
---@return integer retval
function reaper.ImGui_ConfigVar_InputTrickleEventQueue() end

---When holding a key/button, time before it starts repeating, in seconds
---   (for buttons in Repeat mode, etc.).
---@return integer retval
function reaper.ImGui_ConfigVar_KeyRepeatDelay() end

---When holding a key/button, rate at which it repeats, in seconds.
---@return integer retval
function reaper.ImGui_ConfigVar_KeyRepeatRate() end

---OS X style: Text editing cursor movement using Alt instead of Ctrl, Shortcuts
---   using Cmd/Super instead of Ctrl, Line/Text Start and End using Cmd+Arrows
---   instead of Home/End, Double click selects by word instead of selecting whole
---   text, Multi-selection in lists uses Cmd/Super instead of Ctrl.
---@return integer retval
function reaper.ImGui_ConfigVar_MacOSXBehaviors() end

---Distance threshold to stay in to validate a double-click, in pixels.
---@return integer retval
function reaper.ImGui_ConfigVar_MouseDoubleClickMaxDist() end

---Time for a double-click, in seconds.
---@return integer retval
function reaper.ImGui_ConfigVar_MouseDoubleClickTime() end

---Distance threshold before considering we are dragging.
---@return integer retval
function reaper.ImGui_ConfigVar_MouseDragThreshold() end

---Disable default OS window decoration. Enabling decoration can create
---   subsequent issues at OS levels (e.g. minimum window size).
---@return integer retval
function reaper.ImGui_ConfigVar_ViewportsNoDecoration() end

---Enable allowing to move windows only when clicking on their title bar.
---   Does not apply to windows without a title bar.
---@return integer retval
function reaper.ImGui_ConfigVar_WindowsMoveFromTitleBarOnly() end

---Enable resizing of windows from their edges and from the lower-left corner.
---@return integer retval
function reaper.ImGui_ConfigVar_WindowsResizeFromEdges() end

---Create a new ReaImGui context.
---The context will remain valid as long as it is used in each defer cycle.The label is used for the tab text when windows are docked in REAPER
---and also as a unique identifier for storing settings.
---@param label string
---@param config_flags? integer
---@return ImGui_Context 
function reaper.ImGui_CreateContext(label, config_flags) end

---@param draw_list ImGui_DrawList
---@return ImGui_DrawListSplitter 
function reaper.ImGui_CreateDrawListSplitter(draw_list) end

---Load a font matching a font family name or from a font file.
---The font will remain valid while it's attached to a context. See Attach.The family name can be an installed font or one of the generic fonts:
---sans-serif, serif, monospace, cursive, fantasy.If 'family_or_file' specifies a path to a font file (contains a / or \):
---- The first byte of 'flags' is used as the font index within the file
---- The font styles in 'flags' are simulated by the font renderer
---@param family_or_file string
---@param size integer
---@param flags? integer
---@return ImGui_Font 
function reaper.ImGui_CreateFont(family_or_file, size, flags) end

---Compile an EEL program.Standard EEL [math](https://www.reaper.fm/sdk/js/basiccode.php#js_basicfunc)
---and [string](https://www.reaper.fm/sdk/js/strings.php#js_string_funcs)
---functions are available in addition to callback-specific functions
---(see InputTextCallback_*).
---@param code string
---@return ImGui_Function 
function reaper.ImGui_CreateFunctionFromEEL(code) end

---The returned object is valid as long as it is used in each defer cycle
---unless attached to a context (see Attach).('flags' currently unused and reserved for future expansion)
---@param file string
---@param flags? integer
---@return ImGui_Image 
function reaper.ImGui_CreateImage(file, flags) end

---Requires REAPER v6.44 or newer for EEL and Lua. Load from a file using
---CreateImage or explicitely specify data_sz if supporting older versions.
---@param data string
---@return ImGui_Image 
function reaper.ImGui_CreateImageFromMem(data) end

---@return ImGui_ImageSet 
function reaper.ImGui_CreateImageSet() end

---The returned clipper object is only valid for the given context and is valid
---as long as it is used in each defer cycle unless attached (see Attach).
---@param ctx ImGui_Context
---@return ImGui_ListClipper 
function reaper.ImGui_CreateListClipper(ctx) end

---Valid while used every frame unless attached to a context (see Attach).
---@param default_filter? string
---@return ImGui_TextFilter 
function reaper.ImGui_CreateTextFilter(default_filter) end

---Helper tool to diagnose between text encoding issues and font loading issues.
---Pass your UTF-8 string and verify that there are correct.
---@param ctx ImGui_Context
---@param text string
function reaper.ImGui_DebugTextEncoding(ctx, text) end

---Free the resources used by a context.Calling this function is usually not required as all ReaImGui objects are
---automatically garbage-collected when unused.
---@param ctx ImGui_Context
function reaper.ImGui_DestroyContext(ctx) end

---Unlink the object's lifetime. Unattached objects are automatically destroyed
---when left unused. You may check whether an object has been destroyed using
---ValidatePtr.
---@param obj? ImGui_Context
function reaper.ImGui_Detach(obj) end

---@return integer retval
function reaper.ImGui_Dir_Down() end

---@return integer retval
function reaper.ImGui_Dir_Left() end

---@return integer retval
function reaper.ImGui_Dir_None() end

---@return integer retval
function reaper.ImGui_Dir_Right() end

---@return integer retval
function reaper.ImGui_Dir_Up() end

---@param ctx ImGui_Context
---@param label string
---@param v number
---@param v_speed? number
---@param v_min? number
---@param v_max? number
---@param format? string
---@param flags? integer
---@return boolean retval, number v
function reaper.ImGui_DragDouble(ctx, label, v, v_speed, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 number
---@param v2 number
---@param v_speed? number
---@param v_min? number
---@param v_max? number
---@param format? string
---@param flags? integer
---@return boolean retval, number v1, number v2
function reaper.ImGui_DragDouble2(ctx, label, v1, v2, v_speed, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 number
---@param v2 number
---@param v3 number
---@param v_speed? number
---@param v_min? number
---@param v_max? number
---@param format? string
---@param flags? integer
---@return boolean retval, number v1, number v2, number v3
function reaper.ImGui_DragDouble3(ctx, label, v1, v2, v3, v_speed, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 number
---@param v2 number
---@param v3 number
---@param v4 number
---@param v_speed? number
---@param v_min? number
---@param v_max? number
---@param format? string
---@param flags? integer
---@return boolean retval, number v1, number v2, number v3, number v4
function reaper.ImGui_DragDouble4(ctx, label, v1, v2, v3, v4, v_speed, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param values? string
---@param speed? number
---@param min? number
---@param max? number
---@param format? string
---@param flags? integer
---@return boolean 
function reaper.ImGui_DragDoubleN(ctx, values, speed, min, max, format, flags) end

---AcceptDragDropPayload will returns true even before the mouse button is
---   released. You can then check GetDragDropPayload/is_delivery to test if the
---   payload needs to be delivered.
---@return integer retval
function reaper.ImGui_DragDropFlags_AcceptBeforeDelivery() end

---Do not draw the default highlight rectangle when hovering over target.
---@return integer retval
function reaper.ImGui_DragDropFlags_AcceptNoDrawDefaultRect() end

---Request hiding the BeginDragDropSource tooltip from the BeginDragDropTarget site.
---@return integer retval
function reaper.ImGui_DragDropFlags_AcceptNoPreviewTooltip() end

---For peeking ahead and inspecting the payload before delivery.
---   Equivalent to DragDropFlags_AcceptBeforeDelivery |
---   DragDropFlags_AcceptNoDrawDefaultRect.
---@return integer retval
function reaper.ImGui_DragDropFlags_AcceptPeekOnly() end

---@return integer retval
function reaper.ImGui_DragDropFlags_None() end

---Allow items such as Text, Image that have no unique identifier to be used as
---   drag source, by manufacturing a temporary identifier based on their
---   window-relative position. This is extremely unusual within the dear imgui
---   ecosystem and so we made it explicit.
---@return integer retval
function reaper.ImGui_DragDropFlags_SourceAllowNullID() end

---Automatically expire the payload if the source cease to be submitted
---   (otherwise payloads are persisting while being dragged).
---@return integer retval
function reaper.ImGui_DragDropFlags_SourceAutoExpirePayload() end

---External source (from outside of dear imgui), won't attempt to read current
---   item/window info. Will always return true.
---   Only one Extern source can be active simultaneously.
---@return integer retval
function reaper.ImGui_DragDropFlags_SourceExtern() end

---By default, when dragging we clear data so that IsItemHovered will return
---   false, to avoid subsequent user code submitting tooltips. This flag disables
---   this behavior so you can still call IsItemHovered on the source item.
---@return integer retval
function reaper.ImGui_DragDropFlags_SourceNoDisableHover() end

---Disable the behavior that allows to open tree nodes and collapsing header by
---   holding over them while dragging a source item.
---@return integer retval
function reaper.ImGui_DragDropFlags_SourceNoHoldToOpenOthers() end

---By default, a successful call to BeginDragDropSource opens a tooltip so you
---   can display a preview or description of the source contents.
---   This flag disables this behavior.
---@return integer retval
function reaper.ImGui_DragDropFlags_SourceNoPreviewTooltip() end

---@param ctx ImGui_Context
---@param label string
---@param v_current_min number
---@param v_current_max number
---@param v_speed? number
---@param v_min? number
---@param v_max? number
---@param format? string
---@param format_max? string
---@param flags? integer
---@return boolean retval, number v_current_min, number v_current_max
function reaper.ImGui_DragFloatRange2(ctx, label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v integer
---@param v_speed? number
---@param v_min? integer
---@param v_max? integer
---@param format? string
---@param flags? integer
---@return boolean retval, integer v
function reaper.ImGui_DragInt(ctx, label, v, v_speed, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 integer
---@param v2 integer
---@param v_speed? number
---@param v_min? integer
---@param v_max? integer
---@param format? string
---@param flags? integer
---@return boolean retval, integer v1, integer v2
function reaper.ImGui_DragInt2(ctx, label, v1, v2, v_speed, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 integer
---@param v2 integer
---@param v3 integer
---@param v_speed? number
---@param v_min? integer
---@param v_max? integer
---@param format? string
---@param flags? integer
---@return boolean retval, integer v1, integer v2, integer v3
function reaper.ImGui_DragInt3(ctx, label, v1, v2, v3, v_speed, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 integer
---@param v2 integer
---@param v3 integer
---@param v4 integer
---@param v_speed? number
---@param v_min? integer
---@param v_max? integer
---@param format? string
---@param flags? integer
---@return boolean retval, integer v1, integer v2, integer v3, integer v4
function reaper.ImGui_DragInt4(ctx, label, v1, v2, v3, v4, v_speed, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v_current_min integer
---@param v_current_max integer
---@param v_speed? number
---@param v_min? integer
---@param v_max? integer
---@param format? string
---@param format_max? string
---@param flags? integer
---@return boolean retval, integer v_current_min, integer v_current_max
function reaper.ImGui_DragIntRange2(ctx, label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags) end

---DrawList_PathStroke, DrawList_AddPolyline: specify that shape should be
---   closed (Important: this is always == 1 for legacy reason).
---@return integer retval
function reaper.ImGui_DrawFlags_Closed() end

---@return integer retval
function reaper.ImGui_DrawFlags_None() end

---@return integer retval
function reaper.ImGui_DrawFlags_RoundCornersAll() end

---@return integer retval
function reaper.ImGui_DrawFlags_RoundCornersBottom() end

---DrawList_AddRect, DrawList_AddRectFilled, DrawList_PathRect: enable rounding
---   bottom-left corner only (when rounding &gt; 0.0, we default to all corners).
---@return integer retval
function reaper.ImGui_DrawFlags_RoundCornersBottomLeft() end

---DrawList_AddRect, DrawList_AddRectFilled, DrawList_PathRect: enable rounding
---   bottom-right corner only (when rounding &gt; 0.0, we default to all corners).
---@return integer retval
function reaper.ImGui_DrawFlags_RoundCornersBottomRight() end

---@return integer retval
function reaper.ImGui_DrawFlags_RoundCornersLeft() end

---DrawList_AddRect, DrawList_AddRectFilled, DrawList_PathRect: disable rounding
---   on all corners (when rounding &gt; 0.0). This is NOT zero, NOT an implicit flag!.
---@return integer retval
function reaper.ImGui_DrawFlags_RoundCornersNone() end

---@return integer retval
function reaper.ImGui_DrawFlags_RoundCornersRight() end

---@return integer retval
function reaper.ImGui_DrawFlags_RoundCornersTop() end

---DrawList_AddRect, DrawList_AddRectFilled, DrawList_PathRect: enable rounding
---   top-left corner only (when rounding &gt; 0.0, we default to all corners).
---@return integer retval
function reaper.ImGui_DrawFlags_RoundCornersTopLeft() end

---DrawList_AddRect, DrawList_AddRectFilled, DrawList_PathRect: enable rounding
---   top-right corner only (when rounding &gt; 0.0, we default to all corners).
---@return integer retval
function reaper.ImGui_DrawFlags_RoundCornersTopRight() end

---@param splitter ImGui_DrawListSplitter
function reaper.ImGui_DrawListSplitter_Clear(splitter) end

---@param splitter ImGui_DrawListSplitter
function reaper.ImGui_DrawListSplitter_Merge(splitter) end

---@param splitter ImGui_DrawListSplitter
---@param channel_idx integer
function reaper.ImGui_DrawListSplitter_SetCurrentChannel(splitter, channel_idx) end

---@param splitter ImGui_DrawListSplitter
---@param count integer
function reaper.ImGui_DrawListSplitter_Split(splitter, count) end

---Cubic Bezier (4 control points)
---@param draw_list ImGui_DrawList
---@param p1_x number
---@param p1_y number
---@param p2_x number
---@param p2_y number
---@param p3_x number
---@param p3_y number
---@param p4_x number
---@param p4_y number
---@param col_rgba integer
---@param thickness number
---@param num_segments? integer
function reaper.ImGui_DrawList_AddBezierCubic(draw_list, p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, col_rgba, thickness, num_segments) end

---Quadratic Bezier (3 control points)
---@param draw_list ImGui_DrawList
---@param p1_x number
---@param p1_y number
---@param p2_x number
---@param p2_y number
---@param p3_x number
---@param p3_y number
---@param col_rgba integer
---@param thickness number
---@param num_segments? integer
function reaper.ImGui_DrawList_AddBezierQuadratic(draw_list, p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, col_rgba, thickness, num_segments) end

---Use "num_segments == 0" to automatically calculate tessellation (preferred).
---@param draw_list ImGui_DrawList
---@param center_x number
---@param center_y number
---@param radius number
---@param col_rgba integer
---@param num_segments? integer
---@param thickness? number
function reaper.ImGui_DrawList_AddCircle(draw_list, center_x, center_y, radius, col_rgba, num_segments, thickness) end

---Use "num_segments == 0" to automatically calculate tessellation (preferred).
---@param draw_list ImGui_DrawList
---@param center_x number
---@param center_y number
---@param radius number
---@param col_rgba integer
---@param num_segments? integer
function reaper.ImGui_DrawList_AddCircleFilled(draw_list, center_x, center_y, radius, col_rgba, num_segments) end

---Note: Anti-aliased filling requires points to be in clockwise order.
---@param points? ImGui_DrawList
---@param col_rgba integer
function reaper.ImGui_DrawList_AddConvexPolyFilled(points, col_rgba) end

---@param draw_list? ImGui_DrawList
---@param img? ImGui_Image
---@param p_min_x number
---@param p_min_y number
---@param p_max_x number
---@param p_max_y number
---@param uv_min_x? number
---@param uv_min_y? number
---@param uv_max_x? number
---@param uv_max_y? number
---@param col_rgba? integer
function reaper.ImGui_DrawList_AddImage(draw_list, img, p_min_x, p_min_y, p_max_x, p_max_y, uv_min_x, uv_min_y, uv_max_x, uv_max_y, col_rgba) end

---@param drawList? ImGui_DrawList
---@param img? ImGui_Image
---@param p1_x number
---@param p1_y number
---@param p2_x number
---@param p2_y number
---@param p3_x number
---@param p3_y number
---@param p4_x number
---@param p4_y number
---@param uv1_x? number
---@param uv1_y? number
---@param uv2_x? number
---@param uv2_y? number
---@param uv3_x? number
---@param uv3_y? number
---@param uv4_x? number
---@param uv4_y? number
---@param col_rgba? integer
function reaper.ImGui_DrawList_AddImageQuad(drawList, img, p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, uv1_x, uv1_y, uv2_x, uv2_y, uv3_x, uv3_y, uv4_x, uv4_y, col_rgba) end

---@param img? ImGui_DrawList
---@param p_min_x number
---@param p_min_y number
---@param p_max_x number
---@param p_max_y number
---@param uv_min_x number
---@param uv_min_y number
---@param uv_max_x number
---@param uv_max_y number
---@param col_rgba integer
---@param rounding number
---@param flags? integer
function reaper.ImGui_DrawList_AddImageRounded(img, p_min_x, p_min_y, p_max_x, p_max_y, uv_min_x, uv_min_y, uv_max_x, uv_max_y, col_rgba, rounding, flags) end

---@param draw_list ImGui_DrawList
---@param p1_x number
---@param p1_y number
---@param p2_x number
---@param p2_y number
---@param col_rgba integer
---@param thickness? number
function reaper.ImGui_DrawList_AddLine(draw_list, p1_x, p1_y, p2_x, p2_y, col_rgba, thickness) end

---@param draw_list ImGui_DrawList
---@param center_x number
---@param center_y number
---@param radius number
---@param col_rgba integer
---@param num_segments integer
---@param thickness? number
function reaper.ImGui_DrawList_AddNgon(draw_list, center_x, center_y, radius, col_rgba, num_segments, thickness) end

---@param draw_list ImGui_DrawList
---@param center_x number
---@param center_y number
---@param radius number
---@param col_rgba integer
---@param num_segments integer
function reaper.ImGui_DrawList_AddNgonFilled(draw_list, center_x, center_y, radius, col_rgba, num_segments) end

---Points is a list of x,y coordinates.
---@param points? ImGui_DrawList
---@param col_rgba integer
---@param flags integer
---@param thickness number
function reaper.ImGui_DrawList_AddPolyline(points, col_rgba, flags, thickness) end

---@param draw_list ImGui_DrawList
---@param p1_x number
---@param p1_y number
---@param p2_x number
---@param p2_y number
---@param p3_x number
---@param p3_y number
---@param p4_x number
---@param p4_y number
---@param col_rgba integer
---@param thickness? number
function reaper.ImGui_DrawList_AddQuad(draw_list, p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, col_rgba, thickness) end

---@param draw_list ImGui_DrawList
---@param p1_x number
---@param p1_y number
---@param p2_x number
---@param p2_y number
---@param p3_x number
---@param p3_y number
---@param p4_x number
---@param p4_y number
---@param col_rgba integer
function reaper.ImGui_DrawList_AddQuadFilled(draw_list, p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, col_rgba) end

---@param draw_list ImGui_DrawList
---@param p_min_x number
---@param p_min_y number
---@param p_max_x number
---@param p_max_y number
---@param col_rgba integer
---@param rounding? number
---@param flags? integer
---@param thickness? number
function reaper.ImGui_DrawList_AddRect(draw_list, p_min_x, p_min_y, p_max_x, p_max_y, col_rgba, rounding, flags, thickness) end

---@param draw_list ImGui_DrawList
---@param p_min_x number
---@param p_min_y number
---@param p_max_x number
---@param p_max_y number
---@param col_rgba integer
---@param rounding? number
---@param flags? integer
function reaper.ImGui_DrawList_AddRectFilled(draw_list, p_min_x, p_min_y, p_max_x, p_max_y, col_rgba, rounding, flags) end

---@param draw_list ImGui_DrawList
---@param p_min_x number
---@param p_min_y number
---@param p_max_x number
---@param p_max_y number
---@param col_upr_left integer
---@param col_upr_right integer
---@param col_bot_right integer
---@param col_bot_left integer
function reaper.ImGui_DrawList_AddRectFilledMultiColor(draw_list, p_min_x, p_min_y, p_max_x, p_max_y, col_upr_left, col_upr_right, col_bot_right, col_bot_left) end

---@param draw_list ImGui_DrawList
---@param x number
---@param y number
---@param col_rgba integer
---@param text string
function reaper.ImGui_DrawList_AddText(draw_list, x, y, col_rgba, text) end

---The last pushed font is used if font is nil.
---The size of the last pushed font is used if font_size is 0.
---cpu_fine_clip_rect_* only takes effect if all four are non-nil.
---@param draw_list? ImGui_DrawList
---@param font? ImGui_Font
---@param font_size number
---@param pos_x number
---@param pos_y number
---@param col_rgba integer
---@param text string
---@param wrap_width? number
---@param cpu_fine_clip_rect_x? number
---@param cpu_fine_clip_rect_y? number
---@param cpu_fine_clip_rect_w? number
---@param cpu_fine_clip_rect_h? number
function reaper.ImGui_DrawList_AddTextEx(draw_list, font, font_size, pos_x, pos_y, col_rgba, text, wrap_width, cpu_fine_clip_rect_x, cpu_fine_clip_rect_y, cpu_fine_clip_rect_w, cpu_fine_clip_rect_h) end

---@param draw_list ImGui_DrawList
---@param p1_x number
---@param p1_y number
---@param p2_x number
---@param p2_y number
---@param p3_x number
---@param p3_y number
---@param col_rgba integer
---@param thickness? number
function reaper.ImGui_DrawList_AddTriangle(draw_list, p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, col_rgba, thickness) end

---@param draw_list ImGui_DrawList
---@param p1_x number
---@param p1_y number
---@param p2_x number
---@param p2_y number
---@param p3_x number
---@param p3_y number
---@param col_rgba integer
function reaper.ImGui_DrawList_AddTriangleFilled(draw_list, p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, col_rgba) end

---@param draw_list ImGui_DrawList
---@param center_x number
---@param center_y number
---@param radius number
---@param a_min number
---@param a_max number
---@param num_segments? integer
function reaper.ImGui_DrawList_PathArcTo(draw_list, center_x, center_y, radius, a_min, a_max, num_segments) end

---Use precomputed angles for a 12 steps circle.
---@param draw_list ImGui_DrawList
---@param center_x number
---@param center_y number
---@param radius number
---@param a_min_of_12 integer
---@param a_max_of_12 integer
function reaper.ImGui_DrawList_PathArcToFast(draw_list, center_x, center_y, radius, a_min_of_12, a_max_of_12) end

---Cubic Bezier (4 control points)
---@param draw_list ImGui_DrawList
---@param p2_x number
---@param p2_y number
---@param p3_x number
---@param p3_y number
---@param p4_x number
---@param p4_y number
---@param num_segments? integer
function reaper.ImGui_DrawList_PathBezierCubicCurveTo(draw_list, p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, num_segments) end

---Quadratic Bezier (3 control points)
---@param draw_list ImGui_DrawList
---@param p2_x number
---@param p2_y number
---@param p3_x number
---@param p3_y number
---@param num_segments? integer
function reaper.ImGui_DrawList_PathBezierQuadraticCurveTo(draw_list, p2_x, p2_y, p3_x, p3_y, num_segments) end

---@param draw_list ImGui_DrawList
function reaper.ImGui_DrawList_PathClear(draw_list) end

---Note: Anti-aliased filling requires points to be in clockwise order.
---@param draw_list ImGui_DrawList
---@param col_rgba integer
function reaper.ImGui_DrawList_PathFillConvex(draw_list, col_rgba) end

---@param draw_list ImGui_DrawList
---@param pos_x number
---@param pos_y number
function reaper.ImGui_DrawList_PathLineTo(draw_list, pos_x, pos_y) end

---@param draw_list ImGui_DrawList
---@param rect_min_x number
---@param rect_min_y number
---@param rect_max_x number
---@param rect_max_y number
---@param rounding? number
---@param flags? integer
function reaper.ImGui_DrawList_PathRect(draw_list, rect_min_x, rect_min_y, rect_max_x, rect_max_y, rounding, flags) end

---@param draw_list ImGui_DrawList
---@param col_rgba integer
---@param flags? integer
---@param thickness? number
function reaper.ImGui_DrawList_PathStroke(draw_list, col_rgba, flags, thickness) end

---See DrawList_PushClipRect
---@param draw_list ImGui_DrawList
function reaper.ImGui_DrawList_PopClipRect(draw_list) end

---Render-level scissoring. Prefer using higher-level PushClipRect to affect
---logic (hit-testing and widget culling).
---@param draw_list ImGui_DrawList
---@param clip_rect_min_x number
---@param clip_rect_min_y number
---@param clip_rect_max_x number
---@param clip_rect_max_y number
---@param intersect_with_current_clip_rect? boolean
function reaper.ImGui_DrawList_PushClipRect(draw_list, clip_rect_min_x, clip_rect_min_y, clip_rect_max_x, clip_rect_max_y, intersect_with_current_clip_rect) end

---@param draw_list ImGui_DrawList
function reaper.ImGui_DrawList_PushClipRectFullScreen(draw_list) end

---Add a dummy item of given size. unlike InvisibleButton, Dummy() won't take the
---mouse click or be navigable into.
---@param ctx ImGui_Context
---@param size_w number
---@param size_h number
function reaper.ImGui_Dummy(ctx, size_w, size_h) end

---Pop window from the stack. See Begin.
---@param ctx ImGui_Context
function reaper.ImGui_End(ctx) end

---See BeginChild.
---@param ctx ImGui_Context
function reaper.ImGui_EndChild(ctx) end

---See BeginChildFrame.
---@param ctx ImGui_Context
function reaper.ImGui_EndChildFrame(ctx) end

---Only call EndCombo() if BeginCombo returns true!
---@param ctx ImGui_Context
function reaper.ImGui_EndCombo(ctx) end

---See BeginDisabled.
---@param ctx ImGui_Context
function reaper.ImGui_EndDisabled(ctx) end

---Only call EndDragDropSource() if BeginDragDropSource returns true!
---@param ctx ImGui_Context
function reaper.ImGui_EndDragDropSource(ctx) end

---Only call EndDragDropTarget() if BeginDragDropTarget returns true!
---@param ctx ImGui_Context
function reaper.ImGui_EndDragDropTarget(ctx) end

---Unlock horizontal starting position + capture the whole group bounding box
---into one "item" (so you can use IsItemHovered or layout primitives such as
---SameLine on whole group, etc.).See BeginGroup.
---@param ctx ImGui_Context
function reaper.ImGui_EndGroup(ctx) end

---Only call EndListBox() if BeginListBox returned true!
---@param ctx ImGui_Context
function reaper.ImGui_EndListBox(ctx) end

---Only call EndMenu() if BeginMenu returns true!
---@param ctx ImGui_Context
function reaper.ImGui_EndMenu(ctx) end

---Only call EndMenuBar if BeginMenuBar returns true!
---@param ctx ImGui_Context
function reaper.ImGui_EndMenuBar(ctx) end

---Only call EndPopup() if BeginPopup*() returns true!
---@param ctx ImGui_Context
function reaper.ImGui_EndPopup(ctx) end

---Only call EndTabBar() if BeginTabBar() returns true!
---@param ctx ImGui_Context
function reaper.ImGui_EndTabBar(ctx) end

---Only call EndTabItem() if BeginTabItem() returns true!
---@param ctx ImGui_Context
function reaper.ImGui_EndTabItem(ctx) end

---Only call EndTable() if BeginTable() returns true!
---@param ctx ImGui_Context
function reaper.ImGui_EndTable(ctx) end

---Only call EndTooltip() if BeginTooltip() returns true.
---@param ctx ImGui_Context
function reaper.ImGui_EndTooltip(ctx) end

---Return true if any window is focused.
---@return integer retval
function reaper.ImGui_FocusedFlags_AnyWindow() end

---Return true if any children of the window is focused.
---@return integer retval
function reaper.ImGui_FocusedFlags_ChildWindows() end

---Consider docking hierarchy (treat dockspace host as parent of docked window)
---   (when used with _ChildWindows or _RootWindow).
---@return integer retval
function reaper.ImGui_FocusedFlags_DockHierarchy() end

---Do not consider popup hierarchy (do not treat popup emitter as parent of
---   popup) (when used with _ChildWindows or _RootWindow).
---@return integer retval
function reaper.ImGui_FocusedFlags_NoPopupHierarchy() end

---@return integer retval
function reaper.ImGui_FocusedFlags_None() end

---FocusedFlags_RootWindow | FocusedFlags_ChildWindows
---@return integer retval
function reaper.ImGui_FocusedFlags_RootAndChildWindows() end

---Test from root window (top most parent of the current hierarchy).
---@return integer retval
function reaper.ImGui_FocusedFlags_RootWindow() end

---@return integer retval
function reaper.ImGui_FontFlags_Bold() end

---@return integer retval
function reaper.ImGui_FontFlags_Italic() end

---@return integer retval
function reaper.ImGui_FontFlags_None() end

---@param func ImGui_Function
function reaper.ImGui_Function_Execute(func) end

---@param func ImGui_Function
---@param name string
---@return number retval
function reaper.ImGui_Function_GetValue(func, name) end

---Copy the values in the function's memory starting at the address stored
---in the given variable into the array.
---@param func ImGui_Function
---@param values? string
function reaper.ImGui_Function_GetValue_Array(func, values) end

---Read from a string slot or a named string (when name starts with a `#`).
---@param func ImGui_Function
---@param name string
---@return string value
function reaper.ImGui_Function_GetValue_String(func, name) end

---@param func ImGui_Function
---@param name string
---@param value number
function reaper.ImGui_Function_SetValue(func, name, value) end

---Copy the values in the array to the function's memory at the address stored
---in the given variable.
---@param func ImGui_Function
---@param values? string
function reaper.ImGui_Function_SetValue_Array(func, values) end

---Write to a string slot or a named string (when name starts with a `#`).
---@param func ImGui_Function
---@param name string
---@param value string
function reaper.ImGui_Function_SetValue_String(func, name, value) end

---This draw list will be the first rendering one. Useful to quickly draw
---shapes/text behind dear imgui contents.
---@param ctx ImGui_Context
---@return ImGui_DrawList 
function reaper.ImGui_GetBackgroundDrawList(ctx) end

---@param ctx ImGui_Context
---@return string retval
function reaper.ImGui_GetClipboardText(ctx) end

---Retrieve given style color with style alpha applied and optional extra alpha
---multiplier, packed as a 32-bit value (RGBA). See Col_* for available style colors.
---@param ctx ImGui_Context
---@param idx integer
---@param alpha_mul? number
---@return integer retval
function reaper.ImGui_GetColor(ctx, idx, alpha_mul) end

---Retrieve given color with style alpha applied, packed as a 32-bit value (RGBA).
---@param ctx ImGui_Context
---@param col_rgba integer
---@return integer retval
function reaper.ImGui_GetColorEx(ctx, col_rgba) end

---@param ctx ImGui_Context
---@param var_idx integer
---@return number retval
function reaper.ImGui_GetConfigVar(ctx, var_idx) end

---== GetContentRegionMax() - GetCursorPos()
---@param ctx ImGui_Context
---@return number x, number y
function reaper.ImGui_GetContentRegionAvail(ctx) end

---Current content boundaries (typically window boundaries including scrolling,
---or current column boundaries), in windows coordinates.
---@param ctx ImGui_Context
---@return number x, number y
function reaper.ImGui_GetContentRegionMax(ctx) end

---Cursor position in window
---@param ctx ImGui_Context
---@return number x, number y
function reaper.ImGui_GetCursorPos(ctx) end

---Cursor X position in window
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetCursorPosX(ctx) end

---Cursor Y position in window
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetCursorPosY(ctx) end

---Cursor position in absolute screen coordinates (useful to work with the DrawList API).
---@param ctx ImGui_Context
---@return number x, number y
function reaper.ImGui_GetCursorScreenPos(ctx) end

---Initial cursor position in window coordinates.
---@param ctx ImGui_Context
---@return number x, number y
function reaper.ImGui_GetCursorStartPos(ctx) end

---Time elapsed since last frame, in seconds.
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetDeltaTime(ctx) end

---Peek directly into the current payload from anywhere.
---@param ctx ImGui_Context
---@return boolean retval, string type, string payload, boolean is_preview, boolean is_delivery
function reaper.ImGui_GetDragDropPayload(ctx) end

---Get a filename from the list of dropped files.
---Returns false if index is out of bounds.
---@param ctx ImGui_Context
---@param index integer
---@return boolean retval, string filename
function reaper.ImGui_GetDragDropPayloadFile(ctx, index) end

---Get the current font
---@param ctx ImGui_Context
---@return ImGui_Font 
function reaper.ImGui_GetFont(ctx) end

---Get current font size (= height in pixels) of current font with current scale
---applied.
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetFontSize(ctx) end

---This draw list will be the last rendered one. Useful to quickly draw
---shapes/text over dear imgui contents.
---@param ctx ImGui_Context
---@return ImGui_DrawList 
function reaper.ImGui_GetForegroundDrawList(ctx) end

---Get global imgui frame count. incremented by 1 every frame.
---@param ctx ImGui_Context
---@return integer retval
function reaper.ImGui_GetFrameCount(ctx) end

---GetFontSize + StyleVar_FramePadding.y * 2
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetFrameHeight(ctx) end

---GetFontSize + StyleVar_FramePadding.y * 2 + StyleVar_ItemSpacing.y
---(distance in pixels between 2 consecutive lines of framed widgets).
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetFrameHeightWithSpacing(ctx) end

---Estimate of application framerate (rolling average over 60 frames, based on
---GetDeltaTime), in frame per second. Solely for convenience.
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetFramerate(ctx) end

---Read from ImGui's character input queue.
---Call with increasing idx until false is returned.
---@param ctx ImGui_Context
---@param idx integer
---@return boolean retval, integer unicode_char
function reaper.ImGui_GetInputQueueCharacter(ctx, idx) end

---Get lower-right bounding rectangle of the last item (screen space)
---@param ctx ImGui_Context
---@return number x, number y
function reaper.ImGui_GetItemRectMax(ctx) end

---Get upper-left bounding rectangle of the last item (screen space)
---@param ctx ImGui_Context
---@return number x, number y
function reaper.ImGui_GetItemRectMin(ctx) end

---Get size of last item
---@param ctx ImGui_Context
---@return number w, number h
function reaper.ImGui_GetItemRectSize(ctx) end

---Duration the keyboard key has been down (0.0 == just pressed)
---@param ctx ImGui_Context
---@param key integer
---@return number retval
function reaper.ImGui_GetKeyDownDuration(ctx, key) end

---Flags for the Ctrl/Shift/Alt/Super keys. Uses Mod_* values.
---@param ctx ImGui_Context
---@return integer retval
function reaper.ImGui_GetKeyMods(ctx) end

---Uses provided repeat rate/delay. Return a count, most often 0 or 1 but might
---be &gt;1 if ConfigVar_RepeatRate is small enough that GetDeltaTime &gt; RepeatRate.
---@param ctx ImGui_Context
---@param key integer
---@param repeat_delay number
---@param rate number
---@return integer retval
function reaper.ImGui_GetKeyPressedAmount(ctx, key, repeat_delay, rate) end

---Currently represents REAPER's main window (arrange view).
---WARNING: This may change or be removed in the future.
---@param ctx ImGui_Context
---@return ImGui_Viewport 
function reaper.ImGui_GetMainViewport(ctx) end

---Return the number of successive mouse-clicks at the time where a click happen (otherwise 0).
---@param ctx ImGui_Context
---@param button integer
---@return integer retval
function reaper.ImGui_GetMouseClickedCount(ctx, button) end

---@param ctx ImGui_Context
---@param button integer
---@return number x, number y
function reaper.ImGui_GetMouseClickedPos(ctx, button) end

---Get desired mouse cursor shape, reset every frame. This is updated during the frame.
---@param ctx ImGui_Context
---@return integer retval
function reaper.ImGui_GetMouseCursor(ctx) end

---Mouse delta. Note that this is zero if either current or previous position
---are invalid (-FLT_MAX,-FLT_MAX), so a disappearing/reappearing mouse won't have
---a huge delta.
---@param ctx ImGui_Context
---@return number x, number y
function reaper.ImGui_GetMouseDelta(ctx) end

---Duration the mouse button has been down (0.0 == just clicked)
---@param ctx ImGui_Context
---@param button integer
---@return number retval
function reaper.ImGui_GetMouseDownDuration(ctx, button) end

---Return the delta from the initial clicking position while the mouse button is
---pressed or was just released. This is locked and return 0.0 until the mouse
---moves past a distance threshold at least once (if lock_threshold &lt; -1.0, uses
---ConfigVar_MouseDragThreshold).
---@param ctx ImGui_Context
---@param x number
---@param y number
---@param button? integer
---@param lock_threshold? number
---@return number x, number y
function reaper.ImGui_GetMouseDragDelta(ctx, x, y, button, lock_threshold) end

---@param ctx ImGui_Context
---@return number x, number y
function reaper.ImGui_GetMousePos(ctx) end

---Retrieve mouse position at the time of opening popup we have BeginPopup()
---into (helper to avoid user backing that value themselves).
---@param ctx ImGui_Context
---@return number x, number y
function reaper.ImGui_GetMousePosOnOpeningCurrentPopup(ctx) end

---Vertical: 1 unit scrolls about 5 lines text. &gt;0 scrolls Up, &lt;0 scrolls Down.
---Hold SHIFT to turn vertical scroll into horizontal scrollHorizontal: &gt;0 scrolls Left, &lt;0 scrolls Right.
---Most users don't have a mouse with a horizontal wheel.
---@param ctx ImGui_Context
---@return number vertical, number horizontal
function reaper.ImGui_GetMouseWheel(ctx) end

---Get maximum scrolling amount ~~ ContentSize.x - WindowSize.x - DecorationsSize.x
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetScrollMaxX(ctx) end

---Get maximum scrolling amount ~~ ContentSize.y - WindowSize.y - DecorationsSize.y
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetScrollMaxY(ctx) end

---Get scrolling amount [0 .. GetScrollMaxX()]
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetScrollX(ctx) end

---Get scrolling amount [0 .. GetScrollMaxY()]
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetScrollY(ctx) end

---Retrieve style color as stored in ImGuiStyle structure.
---Use to feed back into PushStyleColor, Otherwise use GetColor to get style color
---with style alpha baked in. See Col_* for available style colors.
---@param ctx ImGui_Context
---@param idx integer
---@return integer retval
function reaper.ImGui_GetStyleColor(ctx, idx) end

---@param ctx ImGui_Context
---@param var_idx integer
---@return number val1, number val2
function reaper.ImGui_GetStyleVar(ctx, var_idx) end

---Same as GetFontSize
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetTextLineHeight(ctx) end

---GetFontSize + StyleVar_ItemSpacing.y
---(distance in pixels between 2 consecutive lines of text).
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetTextLineHeightWithSpacing(ctx) end

---Get global imgui time. Incremented every frame.
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetTime(ctx) end

---Horizontal distance preceding label when using TreeNode*() or Bullet()
---== (GetFontSize + StyleVar_FramePadding.x*2) for a regular unframed TreeNode.
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetTreeNodeToLabelSpacing(ctx) end

---@return string imgui_version, integer imgui_version_num, string reaimgui_version
function reaper.ImGui_GetVersion() end

---Content boundaries max (roughly (0,0)+Size-Scroll) where Size can be
---overridden with SetNextWindowContentSize, in window coordinates.
---@param ctx ImGui_Context
---@return number x, number y
function reaper.ImGui_GetWindowContentRegionMax(ctx) end

---Content boundaries min (roughly (0,0)-Scroll), in window coordinates.
---@param ctx ImGui_Context
---@return number x, number y
function reaper.ImGui_GetWindowContentRegionMin(ctx) end

---@param ctx ImGui_Context
---@return integer retval
function reaper.ImGui_GetWindowDockID(ctx) end

---Get DPI scale currently associated to the current window's viewport
---(1.0 = 96 DPI).
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetWindowDpiScale(ctx) end

---The draw list associated to the current window, to append your own drawing primitives
---@param ctx ImGui_Context
---@return ImGui_DrawList 
function reaper.ImGui_GetWindowDrawList(ctx) end

---Get current window height (shortcut for (select(2, GetWindowSize())).
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetWindowHeight(ctx) end

---Get current window position in screen space (useful if you want to do your own
---drawing via the DrawList API).
---@param ctx ImGui_Context
---@return number x, number y
function reaper.ImGui_GetWindowPos(ctx) end

---Get current window size
---@param ctx ImGui_Context
---@return number w, number h
function reaper.ImGui_GetWindowSize(ctx) end

---Get viewport currently associated to the current window.
---@param ctx ImGui_Context
---@return ImGui_Viewport 
function reaper.ImGui_GetWindowViewport(ctx) end

---Get current window width (shortcut for (select(1, GetWindowSize())).
---@param ctx ImGui_Context
---@return number retval
function reaper.ImGui_GetWindowWidth(ctx) end

---Return true even if an active item is blocking access to this item/window.
---  Useful for Drag and Drop patterns.
---@return integer retval
function reaper.ImGui_HoveredFlags_AllowWhenBlockedByActiveItem() end

---Return true even if a popup window is normally blocking access to this item/window.
---@return integer retval
function reaper.ImGui_HoveredFlags_AllowWhenBlockedByPopup() end

---IsItemHovered only: Return true even if the item is disabled.
---@return integer retval
function reaper.ImGui_HoveredFlags_AllowWhenDisabled() end

---IsItemHovered only: Return true even if the position is obstructed or
---  overlapped by another window.
---@return integer retval
function reaper.ImGui_HoveredFlags_AllowWhenOverlapped() end

---IsWindowHovered only: Return true if any window is hovered.
---@return integer retval
function reaper.ImGui_HoveredFlags_AnyWindow() end

---IsWindowHovered only: Return true if any children of the window is hovered.
---@return integer retval
function reaper.ImGui_HoveredFlags_ChildWindows() end

---Return true after ConfigVar_HoverDelayNormal elapsed (~0.30 sec)
---@return integer retval
function reaper.ImGui_HoveredFlags_DelayNormal() end

---Return true after ConfigVar_HoverDelayShort elapsed (~0.10 sec)
---@return integer retval
function reaper.ImGui_HoveredFlags_DelayShort() end

---IsWindowHovered only: Consider docking hierarchy (treat dockspace host as
---  parent of docked window) (when used with _ChildWindows or _RootWindow).
---@return integer retval
function reaper.ImGui_HoveredFlags_DockHierarchy() end

---Disable using gamepad/keyboard navigation state when active, always query mouse.
---@return integer retval
function reaper.ImGui_HoveredFlags_NoNavOverride() end

---IsWindowHovered only: Do not consider popup hierarchy (do not treat popup
---  emitter as parent of popup) (when used with _ChildWindows or _RootWindow).
---@return integer retval
function reaper.ImGui_HoveredFlags_NoPopupHierarchy() end

---Disable shared delay system where moving from one item to the next keeps
---  the previous timer for a short time (standard for tooltips with long delays
---@return integer retval
function reaper.ImGui_HoveredFlags_NoSharedDelay() end

---Return true if directly over the item/window, not obstructed by another
---  window, not obstructed by an active popup or modal blocking inputs under them.
---@return integer retval
function reaper.ImGui_HoveredFlags_None() end

---HoveredFlags_AllowWhenBlockedByPopup |
---  HoveredFlags_AllowWhenBlockedByActiveItem | HoveredFlags_AllowWhenOverlapped
---@return integer retval
function reaper.ImGui_HoveredFlags_RectOnly() end

---HoveredFlags_RootWindow | HoveredFlags_ChildWindows
---@return integer retval
function reaper.ImGui_HoveredFlags_RootAndChildWindows() end

---IsWindowHovered only: Test from root window (top most parent of the current hierarchy).
---@return integer retval
function reaper.ImGui_HoveredFlags_RootWindow() end

---@param img? ImGui_Context
---@param size_w number
---@param size_h number
---@param uv0_x? number
---@param uv0_y? number
---@param uv1_x? number
---@param uv1_y? number
---@param tint_col_rgba? integer
---@param border_col_rgba? integer
function reaper.ImGui_Image(img, size_w, size_h, uv0_x, uv0_y, uv1_x, uv1_y, tint_col_rgba, border_col_rgba) end

---@param ctx ImGui_Context
---@param img? string
---@param size_w number
---@param size_h number
---@param uv0_x? number
---@param uv0_y? number
---@param uv1_x? number
---@param uv1_y? number
---@param bg_col_rgba? integer
---@param tint_col_rgba? integer
---@return boolean 
function reaper.ImGui_ImageButton(ctx, img, size_w, size_h, uv0_x, uv0_y, uv1_x, uv1_y, bg_col_rgba, tint_col_rgba) end

---'img' cannot be another ImageSet.
---@param set ImGui_ImageSet
---@param img? number
function reaper.ImGui_ImageSet_Add(set, img) end

---@param img ImGui_Image
---@return number w, number h
function reaper.ImGui_Image_GetSize(img) end

---Move content position toward the right, by 'indent_w', or
---StyleVar_IndentSpacing if 'indent_w' &lt;= 0. See Unindent.
---@param ctx ImGui_Context
---@param indent_w? number
function reaper.ImGui_Indent(ctx, indent_w) end

---@param ctx ImGui_Context
---@param label string
---@param v number
---@param step? number
---@param step_fast? number
---@param format? string
---@param flags? integer
---@return boolean retval, number v
function reaper.ImGui_InputDouble(ctx, label, v, step, step_fast, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 number
---@param v2 number
---@param format? string
---@param flags? integer
---@return boolean retval, number v1, number v2
function reaper.ImGui_InputDouble2(ctx, label, v1, v2, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 number
---@param v2 number
---@param v3 number
---@param format? string
---@param flags? integer
---@return boolean retval, number v1, number v2, number v3
function reaper.ImGui_InputDouble3(ctx, label, v1, v2, v3, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 number
---@param v2 number
---@param v3 number
---@param v4 number
---@param format? string
---@param flags? integer
---@return boolean retval, number v1, number v2, number v3, number v4
function reaper.ImGui_InputDouble4(ctx, label, v1, v2, v3, v4, format, flags) end

---@param ctx ImGui_Context
---@param values? string
---@param step? number
---@param step_fast? number
---@param format? string
---@param flags? integer
---@return boolean 
function reaper.ImGui_InputDoubleN(ctx, values, step, step_fast, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v integer
---@param step? integer
---@param step_fast? integer
---@param flags? integer
---@return boolean retval, integer v
function reaper.ImGui_InputInt(ctx, label, v, step, step_fast, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 integer
---@param v2 integer
---@param flags? integer
---@return boolean retval, integer v1, integer v2
function reaper.ImGui_InputInt2(ctx, label, v1, v2, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 integer
---@param v2 integer
---@param v3 integer
---@param flags? integer
---@return boolean retval, integer v1, integer v2, integer v3
function reaper.ImGui_InputInt3(ctx, label, v1, v2, v3, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 integer
---@param v2 integer
---@param v3 integer
---@param v4 integer
---@param flags? integer
---@return boolean retval, integer v1, integer v2, integer v3, integer v4
function reaper.ImGui_InputInt4(ctx, label, v1, v2, v3, v4, flags) end

---@param ctx ImGui_Context
---@param label string
---@param buf string
---@param callback? integer
---@return boolean retval, string buf
function reaper.ImGui_InputText(ctx, label, buf, callback) end

---Pressing TAB input a '\t' character into the text field.
---@return integer retval
function reaper.ImGui_InputTextFlags_AllowTabInput() end

---Overwrite mode.
---@return integer retval
function reaper.ImGui_InputTextFlags_AlwaysOverwrite() end

---Select entire text when first taking mouse focus.
---@return integer retval
function reaper.ImGui_InputTextFlags_AutoSelectAll() end

---Callback on each iteration. User code may query cursor position, modify text buffer.
---@return integer retval
function reaper.ImGui_InputTextFlags_CallbackAlways() end

---Callback on character inputs to replace or discard them.
---   Modify 'EventChar' to replace or 'EventChar = 0' to discard.
---@return integer retval
function reaper.ImGui_InputTextFlags_CallbackCharFilter() end

---Callback on pressing TAB (for completion handling).
---@return integer retval
function reaper.ImGui_InputTextFlags_CallbackCompletion() end

---Callback on any edit (note that InputText() already returns true on edit,
---   the callback is useful mainly to manipulate the underlying buffer while
---   focus is active).
---@return integer retval
function reaper.ImGui_InputTextFlags_CallbackEdit() end

---Callback on pressing Up/Down arrows (for history handling).
---@return integer retval
function reaper.ImGui_InputTextFlags_CallbackHistory() end

---Allow 0123456789.+-*/.
---@return integer retval
function reaper.ImGui_InputTextFlags_CharsDecimal() end

---Allow 0123456789ABCDEFabcdef.
---@return integer retval
function reaper.ImGui_InputTextFlags_CharsHexadecimal() end

---Filter out spaces, tabs.
---@return integer retval
function reaper.ImGui_InputTextFlags_CharsNoBlank() end

---Allow 0123456789.+-*/eE (Scientific notation input).
---@return integer retval
function reaper.ImGui_InputTextFlags_CharsScientific() end

---Turn a..z into A..Z.
---@return integer retval
function reaper.ImGui_InputTextFlags_CharsUppercase() end

---In multi-line mode, unfocus with Enter, add new line with Ctrl+Enter
---   (default is opposite: unfocus with Ctrl+Enter, add line with Enter).
---@return integer retval
function reaper.ImGui_InputTextFlags_CtrlEnterForNewLine() end

---Return 'true' when Enter is pressed (as opposed to every time the value was
---   modified). Consider looking at the IsItemDeactivatedAfterEdit function.
---@return integer retval
function reaper.ImGui_InputTextFlags_EnterReturnsTrue() end

---Escape key clears content if not empty, and deactivate otherwise
---   (constrast to default behavior of Escape to revert).
---@return integer retval
function reaper.ImGui_InputTextFlags_EscapeClearsAll() end

---Disable following the cursor horizontally.
---@return integer retval
function reaper.ImGui_InputTextFlags_NoHorizontalScroll() end

---Disable undo/redo. Note that input text owns the text data while active.
---@return integer retval
function reaper.ImGui_InputTextFlags_NoUndoRedo() end

---@return integer retval
function reaper.ImGui_InputTextFlags_None() end

---Password mode, display all characters as '*'.
---@return integer retval
function reaper.ImGui_InputTextFlags_Password() end

---Read-only mode.
---@return integer retval
function reaper.ImGui_InputTextFlags_ReadOnly() end

---@param ctx ImGui_Context
---@param label string
---@param buf string
---@param size_w? number
---@param size_h? number
---@param callback? integer
---@return boolean retval, string buf
function reaper.ImGui_InputTextMultiline(ctx, label, buf, size_w, size_h, callback) end

---@param ctx ImGui_Context
---@param label string
---@param hint string
---@param buf string
---@param callback? integer
---@return boolean retval, string buf
function reaper.ImGui_InputTextWithHint(ctx, label, hint, buf, callback) end

---Flexible button behavior without the visuals, frequently useful to build
---custom behaviors using the public api (along with IsItemActive, IsItemHovered, etc.).
---@param ctx ImGui_Context
---@param str_id string
---@param size_w number
---@param size_h number
---@param flags? integer
---@return boolean 
function reaper.ImGui_InvisibleButton(ctx, str_id, size_w, size_h, flags) end

---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_IsAnyItemActive(ctx) end

---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_IsAnyItemFocused(ctx) end

---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_IsAnyItemHovered(ctx) end

---Is any mouse button held?
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_IsAnyMouseDown(ctx) end

---Was the last item just made active (item was previously inactive).
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_IsItemActivated(ctx) end

---Is the last item active? (e.g. button being held, text field being edited.
---This will continuously return true while holding mouse button on an item.
---Items that don't interact will always return false.
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_IsItemActive(ctx) end

---Is the last item clicked? (e.g. button/node just clicked on)
---== IsMouseClicked(mouse_button) &amp;&amp; IsItemHovered().This is NOT equivalent to the behavior of e.g. Button.
---Most widgets have specific reactions based on mouse-up/down state, mouse position etc.
---@param ctx ImGui_Context
---@param mouse_button? integer
---@return boolean 
function reaper.ImGui_IsItemClicked(ctx, mouse_button) end

---Was the last item just made inactive (item was previously active).
---Useful for Undo/Redo patterns with widgets that require continuous editing.
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_IsItemDeactivated(ctx) end

---Was the last item just made inactive and made a value change when it was
---active? (e.g. Slider/Drag moved).Useful for Undo/Redo patterns with widgets that require continuous editing. Note
---that you may get false positives (some widgets such as Combo/ListBox/Selectable
---will return true even when clicking an already selected item).
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_IsItemDeactivatedAfterEdit(ctx) end

---Did the last item modify its underlying value this frame? or was pressed?
---This is generally the same as the "bool" return value of many widgets.
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_IsItemEdited(ctx) end

---Is the last item focused for keyboard/gamepad navigation?
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_IsItemFocused(ctx) end

---Is the last item hovered? (and usable, aka not blocked by a popup, etc.).
---See HoveredFlags_* for more options.
---@param ctx ImGui_Context
---@param flags? integer
---@return boolean 
function reaper.ImGui_IsItemHovered(ctx, flags) end

---Was the last item open state toggled? Set by TreeNode.
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_IsItemToggledOpen(ctx) end

---Is the last item visible? (items may be out of sight because of clipping/scrolling)
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_IsItemVisible(ctx) end

---Is key being held.
---@param ctx ImGui_Context
---@param key integer
---@return boolean 
function reaper.ImGui_IsKeyDown(ctx, key) end

---Was key pressed (went from !Down to Down)?
---If repeat=true, uses ConfigVar_KeyRepeatDelay / ConfigVar_KeyRepeatRate.
---@param ctx ImGui_Context
---@param key integer
---@param repeats? boolean
---@return boolean 
function reaper.ImGui_IsKeyPressed(ctx, key, repeats) end

---Was key released (went from Down to !Down)?
---@param ctx ImGui_Context
---@param key integer
---@return boolean 
function reaper.ImGui_IsKeyReleased(ctx, key) end

---Did mouse button clicked? (went from !Down to Down).
---Same as GetMouseClickedCount() == 1.
---@param ctx ImGui_Context
---@param button integer
---@param repeats? boolean
---@return boolean 
function reaper.ImGui_IsMouseClicked(ctx, button, repeats) end

---Did mouse button double-clicked? Same as GetMouseClickedCount() == 2.
---(Note that a double-click will also report IsMouseClicked() == true)
---@param ctx ImGui_Context
---@param button integer
---@return boolean 
function reaper.ImGui_IsMouseDoubleClicked(ctx, button) end

---Is mouse button held?
---@param ctx ImGui_Context
---@param button integer
---@return boolean 
function reaper.ImGui_IsMouseDown(ctx, button) end

---Is mouse dragging? (if lock_threshold &lt; -1.0, uses ConfigVar_MouseDragThreshold)
---@param ctx ImGui_Context
---@param button integer
---@param lock_threshold? number
---@return boolean 
function reaper.ImGui_IsMouseDragging(ctx, button, lock_threshold) end

---Is mouse hovering given bounding rect (in screen space).
---Clipped by current clipping settings, but disregarding of other consideration
---of focus/window ordering/popup-block.
---@param ctx ImGui_Context
---@param r_min_x number
---@param r_min_y number
---@param r_max_x number
---@param r_max_y number
---@param clip? boolean
---@return boolean 
function reaper.ImGui_IsMouseHoveringRect(ctx, r_min_x, r_min_y, r_max_x, r_max_y, clip) end

---@param ctx ImGui_Context
---@param mouse_pos_x? number
---@param mouse_pos_y? number
---@return boolean 
function reaper.ImGui_IsMousePosValid(ctx, mouse_pos_x, mouse_pos_y) end

---Did mouse button released? (went from Down to !Down)
---@param ctx ImGui_Context
---@param button integer
---@return boolean 
function reaper.ImGui_IsMouseReleased(ctx, button) end

---Return true if the popup is open at the current BeginPopup level of the
---popup stack.- With PopupFlags_AnyPopupId: return true if any popup is open at the current
---  BeginPopup() level of the popup stack.
---- With PopupFlags_AnyPopupId + PopupFlags_AnyPopupLevel: return true if any
---  popup is open.
---@param ctx ImGui_Context
---@param str_id string
---@param flags? integer
---@return boolean 
function reaper.ImGui_IsPopupOpen(ctx, str_id, flags) end

---Test if rectangle (of given size, starting from cursor position) is
---visible / not clipped.
---@param ctx ImGui_Context
---@param size_w number
---@param size_h number
---@return boolean 
function reaper.ImGui_IsRectVisible(ctx, size_w, size_h) end

---Test if rectangle (in screen space) is visible / not clipped. to perform
---coarse clipping on user's side.
---@param ctx ImGui_Context
---@param rect_min_x number
---@param rect_min_y number
---@param rect_max_x number
---@param rect_max_y number
---@return boolean 
function reaper.ImGui_IsRectVisibleEx(ctx, rect_min_x, rect_min_y, rect_max_x, rect_max_y) end

---Use after Begin/BeginPopup/BeginPopupModal to tell if a window just opened.
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_IsWindowAppearing(ctx) end

---Is current window docked into another window or a REAPER docker?
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_IsWindowDocked(ctx) end

---Is current window focused? or its root/child, depending on flags.
---See flags for options.
---@param ctx ImGui_Context
---@param flags? integer
---@return boolean 
function reaper.ImGui_IsWindowFocused(ctx, flags) end

---Is current window hovered (and typically: not blocked by a popup/modal)?
---See flags for options.
---@param ctx ImGui_Context
---@param flags? integer
---@return boolean 
function reaper.ImGui_IsWindowHovered(ctx, flags) end

---@return integer retval
function reaper.ImGui_Key_0() end

---@return integer retval
function reaper.ImGui_Key_1() end

---@return integer retval
function reaper.ImGui_Key_2() end

---@return integer retval
function reaper.ImGui_Key_3() end

---@return integer retval
function reaper.ImGui_Key_4() end

---@return integer retval
function reaper.ImGui_Key_5() end

---@return integer retval
function reaper.ImGui_Key_6() end

---@return integer retval
function reaper.ImGui_Key_7() end

---@return integer retval
function reaper.ImGui_Key_8() end

---@return integer retval
function reaper.ImGui_Key_9() end

---@return integer retval
function reaper.ImGui_Key_A() end

---'
---@return integer retval
function reaper.ImGui_Key_Apostrophe() end

---@return integer retval
function reaper.ImGui_Key_B() end

---\
---@return integer retval
function reaper.ImGui_Key_Backslash() end

---@return integer retval
function reaper.ImGui_Key_Backspace() end

---@return integer retval
function reaper.ImGui_Key_C() end

---@return integer retval
function reaper.ImGui_Key_CapsLock() end

---,
---@return integer retval
function reaper.ImGui_Key_Comma() end

---@return integer retval
function reaper.ImGui_Key_D() end

---@return integer retval
function reaper.ImGui_Key_Delete() end

---@return integer retval
function reaper.ImGui_Key_DownArrow() end

---@return integer retval
function reaper.ImGui_Key_E() end

---@return integer retval
function reaper.ImGui_Key_End() end

---@return integer retval
function reaper.ImGui_Key_Enter() end

---=
---@return integer retval
function reaper.ImGui_Key_Equal() end

---@return integer retval
function reaper.ImGui_Key_Escape() end

---@return integer retval
function reaper.ImGui_Key_F() end

---@return integer retval
function reaper.ImGui_Key_F1() end

---@return integer retval
function reaper.ImGui_Key_F10() end

---@return integer retval
function reaper.ImGui_Key_F11() end

---@return integer retval
function reaper.ImGui_Key_F12() end

---@return integer retval
function reaper.ImGui_Key_F2() end

---@return integer retval
function reaper.ImGui_Key_F3() end

---@return integer retval
function reaper.ImGui_Key_F4() end

---@return integer retval
function reaper.ImGui_Key_F5() end

---@return integer retval
function reaper.ImGui_Key_F6() end

---@return integer retval
function reaper.ImGui_Key_F7() end

---@return integer retval
function reaper.ImGui_Key_F8() end

---@return integer retval
function reaper.ImGui_Key_F9() end

---@return integer retval
function reaper.ImGui_Key_G() end

---`
---@return integer retval
function reaper.ImGui_Key_GraveAccent() end

---@return integer retval
function reaper.ImGui_Key_H() end

---@return integer retval
function reaper.ImGui_Key_Home() end

---@return integer retval
function reaper.ImGui_Key_I() end

---@return integer retval
function reaper.ImGui_Key_Insert() end

---@return integer retval
function reaper.ImGui_Key_J() end

---@return integer retval
function reaper.ImGui_Key_K() end

---@return integer retval
function reaper.ImGui_Key_Keypad0() end

---@return integer retval
function reaper.ImGui_Key_Keypad1() end

---@return integer retval
function reaper.ImGui_Key_Keypad2() end

---@return integer retval
function reaper.ImGui_Key_Keypad3() end

---@return integer retval
function reaper.ImGui_Key_Keypad4() end

---@return integer retval
function reaper.ImGui_Key_Keypad5() end

---@return integer retval
function reaper.ImGui_Key_Keypad6() end

---@return integer retval
function reaper.ImGui_Key_Keypad7() end

---@return integer retval
function reaper.ImGui_Key_Keypad8() end

---@return integer retval
function reaper.ImGui_Key_Keypad9() end

---@return integer retval
function reaper.ImGui_Key_KeypadAdd() end

---@return integer retval
function reaper.ImGui_Key_KeypadDecimal() end

---@return integer retval
function reaper.ImGui_Key_KeypadDivide() end

---@return integer retval
function reaper.ImGui_Key_KeypadEnter() end

---@return integer retval
function reaper.ImGui_Key_KeypadEqual() end

---@return integer retval
function reaper.ImGui_Key_KeypadMultiply() end

---@return integer retval
function reaper.ImGui_Key_KeypadSubtract() end

---@return integer retval
function reaper.ImGui_Key_L() end

---@return integer retval
function reaper.ImGui_Key_LeftAlt() end

---@return integer retval
function reaper.ImGui_Key_LeftArrow() end

---[
---@return integer retval
function reaper.ImGui_Key_LeftBracket() end

---@return integer retval
function reaper.ImGui_Key_LeftCtrl() end

---@return integer retval
function reaper.ImGui_Key_LeftShift() end

---@return integer retval
function reaper.ImGui_Key_LeftSuper() end

---@return integer retval
function reaper.ImGui_Key_M() end

---@return integer retval
function reaper.ImGui_Key_Menu() end

----
---@return integer retval
function reaper.ImGui_Key_Minus() end

---@return integer retval
function reaper.ImGui_Key_MouseLeft() end

---@return integer retval
function reaper.ImGui_Key_MouseMiddle() end

---@return integer retval
function reaper.ImGui_Key_MouseRight() end

---@return integer retval
function reaper.ImGui_Key_MouseWheelX() end

---@return integer retval
function reaper.ImGui_Key_MouseWheelY() end

---@return integer retval
function reaper.ImGui_Key_MouseX1() end

---@return integer retval
function reaper.ImGui_Key_MouseX2() end

---@return integer retval
function reaper.ImGui_Key_N() end

---@return integer retval
function reaper.ImGui_Key_NumLock() end

---@return integer retval
function reaper.ImGui_Key_O() end

---@return integer retval
function reaper.ImGui_Key_P() end

---@return integer retval
function reaper.ImGui_Key_PageDown() end

---@return integer retval
function reaper.ImGui_Key_PageUp() end

---@return integer retval
function reaper.ImGui_Key_Pause() end

---.
---@return integer retval
function reaper.ImGui_Key_Period() end

---@return integer retval
function reaper.ImGui_Key_PrintScreen() end

---@return integer retval
function reaper.ImGui_Key_Q() end

---@return integer retval
function reaper.ImGui_Key_R() end

---@return integer retval
function reaper.ImGui_Key_RightAlt() end

---@return integer retval
function reaper.ImGui_Key_RightArrow() end

---]
---@return integer retval
function reaper.ImGui_Key_RightBracket() end

---@return integer retval
function reaper.ImGui_Key_RightCtrl() end

---@return integer retval
function reaper.ImGui_Key_RightShift() end

---@return integer retval
function reaper.ImGui_Key_RightSuper() end

---@return integer retval
function reaper.ImGui_Key_S() end

---@return integer retval
function reaper.ImGui_Key_ScrollLock() end

---;
---@return integer retval
function reaper.ImGui_Key_Semicolon() end

---/
---@return integer retval
function reaper.ImGui_Key_Slash() end

---@return integer retval
function reaper.ImGui_Key_Space() end

---@return integer retval
function reaper.ImGui_Key_T() end

---@return integer retval
function reaper.ImGui_Key_Tab() end

---@return integer retval
function reaper.ImGui_Key_U() end

---@return integer retval
function reaper.ImGui_Key_UpArrow() end

---@return integer retval
function reaper.ImGui_Key_V() end

---@return integer retval
function reaper.ImGui_Key_W() end

---@return integer retval
function reaper.ImGui_Key_X() end

---@return integer retval
function reaper.ImGui_Key_Y() end

---@return integer retval
function reaper.ImGui_Key_Z() end

---Display text+label aligned the same way as value+label widgets
---@param ctx ImGui_Context
---@param label string
---@param text string
function reaper.ImGui_LabelText(ctx, label, text) end

---This is an helper over BeginListBox/EndListBox for convenience purpose.Each item must be null-terminated (requires REAPER v6.44 or newer for EEL and Lua).
---@param ctx ImGui_Context
---@param label string
---@param current_item integer
---@param items string
---@param height_in_items? integer
---@return boolean retval, integer current_item
function reaper.ImGui_ListBox(ctx, label, current_item, items, height_in_items) end

---- items_count: Use INT_MAX if you don't know how many items you have
---(in which case the cursor won't be advanced in the final step)
---- items_height: Use -1.0 to be calculated automatically on first step.
---  Otherwise pass in the distance between your items, typically
---  GetTextLineHeightWithSpacing or GetFrameHeightWithSpacing.
---@param clipper ImGui_ListClipper
---@param items_count integer
---@param items_height? number
function reaper.ImGui_ListClipper_Begin(clipper, items_count, items_height) end

---Automatically called on the last call of ListClipper_Step that returns false.
---@param clipper ImGui_ListClipper
function reaper.ImGui_ListClipper_End(clipper) end

---Call ListClipper_ForceDisplayRangeByIndices before first call to
---ListClipper_Step if you need a range of items to be displayed regardless of
---visibility.item_max is exclusive e.g. use (42, 42+1) to make item 42 always visible BUT due
---to alignment/padding of certain items it is likely that an extra item may be
---included on either end of the display range.
---@param clipper ImGui_ListClipper
---@param item_min integer
---@param item_max integer
function reaper.ImGui_ListClipper_ForceDisplayRangeByIndices(clipper, item_min, item_max) end

---@param clipper ImGui_ListClipper
---@return integer display_start, integer display_end
function reaper.ImGui_ListClipper_GetDisplayRange(clipper) end

---Call until it returns false. The display_start/display_end fields from
---ListClipper_GetDisplayRange will be set and you can process/draw those items.
---@param clipper ImGui_ListClipper
---@return boolean 
function reaper.ImGui_ListClipper_Step(clipper) end

---Stop logging (close file, etc.)
---@param ctx ImGui_Context
function reaper.ImGui_LogFinish(ctx) end

---Pass text data straight to log (without being displayed)
---@param ctx ImGui_Context
---@param text string
function reaper.ImGui_LogText(ctx, text) end

---Start logging all text output from the interface to the OS clipboard.
---See also SetClipboardText.
---@param ctx ImGui_Context
---@param auto_open_depth? integer
function reaper.ImGui_LogToClipboard(ctx, auto_open_depth) end

---Start logging all text output from the interface to a file.
---The data is saved to $resource_path/imgui_log.txt if filename is nil.
---@param ctx ImGui_Context
---@param auto_open_depth? integer
---@param filename? string
function reaper.ImGui_LogToFile(ctx, auto_open_depth, filename) end

---Start logging all text output from the interface to the TTY (stdout).
---@param ctx ImGui_Context
---@param auto_open_depth? integer
function reaper.ImGui_LogToTTY(ctx, auto_open_depth) end

---Return true when activated. Shortcuts are displayed for convenience but not
---processed by ImGui at the moment. Toggle state is written to 'selected' when
---provided.
---@param ctx ImGui_Context
---@param label string
---@param shortcut? string
---@param p_selected? boolean
---@param enabled? boolean
---@return boolean retval, boolean|nil p_selected
function reaper.ImGui_MenuItem(ctx, label, shortcut, p_selected, enabled) end

---@return integer retval
function reaper.ImGui_Mod_Alt() end

---@return integer retval
function reaper.ImGui_Mod_Ctrl() end

---@return integer retval
function reaper.ImGui_Mod_None() end

---@return integer retval
function reaper.ImGui_Mod_Shift() end

---Alias for Mod_Ctrl on Linux and Windows and Mod_Super on macOS (Cmd key).
---@return integer retval
function reaper.ImGui_Mod_Shortcut() end

---@return integer retval
function reaper.ImGui_Mod_Super() end

---@return integer retval
function reaper.ImGui_MouseButton_Left() end

---@return integer retval
function reaper.ImGui_MouseButton_Middle() end

---@return integer retval
function reaper.ImGui_MouseButton_Right() end

---@return integer retval
function reaper.ImGui_MouseCursor_Arrow() end

---(Unused by Dear ImGui functions. Use for e.g. hyperlinks)
---@return integer retval
function reaper.ImGui_MouseCursor_Hand() end

---@return integer retval
function reaper.ImGui_MouseCursor_None() end

---When hovering something with disallowed interaction. Usually a crossed circle.
---@return integer retval
function reaper.ImGui_MouseCursor_NotAllowed() end

---(Unused by Dear ImGui functions)
---@return integer retval
function reaper.ImGui_MouseCursor_ResizeAll() end

---When hovering over a vertical border or a column.
---@return integer retval
function reaper.ImGui_MouseCursor_ResizeEW() end

---When hovering over the bottom-left corner of a window.
---@return integer retval
function reaper.ImGui_MouseCursor_ResizeNESW() end

---When hovering over a horizontal border.
---@return integer retval
function reaper.ImGui_MouseCursor_ResizeNS() end

---When hovering over the bottom-right corner of a window.
---@return integer retval
function reaper.ImGui_MouseCursor_ResizeNWSE() end

---When hovering over InputText, etc.
---@return integer retval
function reaper.ImGui_MouseCursor_TextInput() end

---Undo a SameLine() or force a new line when in a horizontal-layout context.
---@param ctx ImGui_Context
function reaper.ImGui_NewLine(ctx) end

---Returns DBL_MIN and DBL_MAX for this system.
---@return number min, number max
function reaper.ImGui_NumericLimits_Double() end

---Returns FLT_MIN and FLT_MAX for this system.
---@return number min, number max
function reaper.ImGui_NumericLimits_Float() end

---Returns INT_MIN and INT_MAX for this system.
---@return integer min, integer max
function reaper.ImGui_NumericLimits_Int() end

---Set popup state to open (don't call every frame!).
---ImGuiPopupFlags are available for opening options.If not modal: they can be closed by clicking anywhere outside them, or by
---pressing ESCAPE.Use PopupFlags_NoOpenOverExistingPopup to avoid opening a popup if there's
---already one at the same level.
---@param ctx ImGui_Context
---@param str_id string
---@param popup_flags? integer
function reaper.ImGui_OpenPopup(ctx, str_id, popup_flags) end

---Helper to open popup when clicked on last item. return true when just opened.
---(Note: actually triggers on the mouse _released_ event to be consistent with
---popup behaviors.)
---@param ctx ImGui_Context
---@param str_id? string
---@param popup_flags? integer
function reaper.ImGui_OpenPopupOnItemClick(ctx, str_id, popup_flags) end

---@param ctx ImGui_Context
---@param values? string
---@param values_offset? integer
---@param overlay_text? string
---@param scale_min? number
---@param scale_max? number
---@param graph_size_w? number
---@param graph_size_h? number
function reaper.ImGui_PlotHistogram(ctx, values, values_offset, overlay_text, scale_min, scale_max, graph_size_w, graph_size_h) end

---@param ctx ImGui_Context
---@param values? string
---@param values_offset? integer
---@param overlay_text? string
---@param scale_min? number
---@param scale_max? number
---@param graph_size_w? number
---@param graph_size_h? number
function reaper.ImGui_PlotLines(ctx, values, values_offset, overlay_text, scale_min, scale_max, graph_size_w, graph_size_h) end

---Convert a position from the current platform's native coordinate position
---system to ReaImGui global coordinates (or vice versa).This effectively flips the Y coordinate on macOS and applies HiDPI scaling on
---Windows and Linux.
---@param ctx ImGui_Context
---@param x number
---@param y number
---@param to_native? boolean
---@return number x, number y
function reaper.ImGui_PointConvertNative(ctx, x, y, to_native) end

---See PushButtonRepeat
---@param ctx ImGui_Context
function reaper.ImGui_PopButtonRepeat(ctx) end

---See PushClipRect
---@param ctx ImGui_Context
function reaper.ImGui_PopClipRect(ctx) end

---See PushFont.
---@param ctx ImGui_Context
function reaper.ImGui_PopFont(ctx) end

---Pop from the ID stack.
---@param ctx ImGui_Context
function reaper.ImGui_PopID(ctx) end

---See PushItemWidth
---@param ctx ImGui_Context
function reaper.ImGui_PopItemWidth(ctx) end

---@param ctx ImGui_Context
---@param count? integer
function reaper.ImGui_PopStyleColor(ctx, count) end

---Reset a style variable.
---@param ctx ImGui_Context
---@param count? integer
function reaper.ImGui_PopStyleVar(ctx, count) end

---See PushTabStop
---@param ctx ImGui_Context
function reaper.ImGui_PopTabStop(ctx) end

---@param ctx ImGui_Context
function reaper.ImGui_PopTextWrapPos(ctx) end

---PopupFlags_AnyPopupId | PopupFlags_AnyPopupLevel
---@return integer retval
function reaper.ImGui_PopupFlags_AnyPopup() end

---For IsPopupOpen: ignore the str_id parameter and test for any popup.
---@return integer retval
function reaper.ImGui_PopupFlags_AnyPopupId() end

---For IsPopupOpen: search/test at any level of the popup stack
---  (default test in the current level).
---@return integer retval
function reaper.ImGui_PopupFlags_AnyPopupLevel() end

---For BeginPopupContext*(): open on Left Mouse release.
---   Guaranteed to always be == 0 (same as MouseButton_Left).
---@return integer retval
function reaper.ImGui_PopupFlags_MouseButtonLeft() end

---For BeginPopupContext*(): open on Middle Mouse release.
---   Guaranteed to always be == 2 (same as MouseButton_Middle).
---@return integer retval
function reaper.ImGui_PopupFlags_MouseButtonMiddle() end

---For BeginPopupContext*(): open on Right Mouse release.
---   Guaranteed to always be == 1 (same as MouseButton_Right).
---@return integer retval
function reaper.ImGui_PopupFlags_MouseButtonRight() end

---For OpenPopup*(), BeginPopupContext*(): don't open if there's already a popup
---   at the same level of the popup stack.
---@return integer retval
function reaper.ImGui_PopupFlags_NoOpenOverExistingPopup() end

---For BeginPopupContextWindow: don't return true when hovering items,
---   only when hovering empty space.
---@return integer retval
function reaper.ImGui_PopupFlags_NoOpenOverItems() end

---@return integer retval
function reaper.ImGui_PopupFlags_None() end

---@param ctx ImGui_Context
---@param fraction number
---@param size_arg_w? number
---@param size_arg_h? number
---@param overlay? string
function reaper.ImGui_ProgressBar(ctx, fraction, size_arg_w, size_arg_h, overlay) end

---In 'repeat' mode, Button*() functions return repeated true in a typematic
---manner (using ConfigVar_KeyRepeatDelay/ConfigVar_KeyRepeatRate settings).Note that you can call IsItemActive after any Button to tell if the button is
---held in the current frame.
---@param ctx ImGui_Context
---@param repeat_ boolean
function reaper.ImGui_PushButtonRepeat(ctx, repeat_) end

---@param ctx ImGui_Context
---@param clip_rect_min_x number
---@param clip_rect_min_y number
---@param clip_rect_max_x number
---@param clip_rect_max_y number
---@param intersect_with_current_clip_rect boolean
function reaper.ImGui_PushClipRect(ctx, clip_rect_min_x, clip_rect_min_y, clip_rect_max_x, clip_rect_max_y, intersect_with_current_clip_rect) end

---Change the current font. Use nil to push the default font.
---The font object must have been registered using Attach. See PopFont.
---@param ctx? ImGui_Context
---@param font? ImGui_Font
function reaper.ImGui_PushFont(ctx, font) end

---Push string into the ID stack.
---@param ctx ImGui_Context
---@param str_id string
function reaper.ImGui_PushID(ctx, str_id) end

---Push width of items for common large "item+label" widgets.- \&gt;0.0: width in pixels
---- &lt;0.0 align xx pixels to the right of window
---  (so -FLT_MIN always align width to the right side)
---- 0.0 = default to ~2/3 of windows width.
---@param ctx ImGui_Context
---@param item_width number
function reaper.ImGui_PushItemWidth(ctx, item_width) end

---Temporarily modify a style color.
---Call PopStyleColor to undo after use (before the end of the frame).
---See Col_* for available style colors.
---@param ctx ImGui_Context
---@param idx integer
---@param col_rgba integer
function reaper.ImGui_PushStyleColor(ctx, idx, col_rgba) end

---Temporarily modify a style variable.
---Call PopStyleVar to undo after use (before the end of the frame).
---See StyleVar_* for possible values of 'var_idx'.
---@param ctx ImGui_Context
---@param var_idx integer
---@param val1 number
---@param val2? number
function reaper.ImGui_PushStyleVar(ctx, var_idx, val1, val2) end

---Allow focusing using TAB/Shift-TAB, enabled by default but you can disable it
---for certain widgets
---@param ctx ImGui_Context
---@param tab_stop boolean
function reaper.ImGui_PushTabStop(ctx, tab_stop) end

---Push word-wrapping position for Text*() commands.-  &lt; 0.0: no wrapping
----  = 0.0: wrap to end of window (or column)
---- \&gt; 0.0: wrap at 'wrap_pos_x' position in window local space.
---@param ctx ImGui_Context
---@param wrap_local_pos_x? number
function reaper.ImGui_PushTextWrapPos(ctx, wrap_local_pos_x) end

---Use with e.g. if (RadioButton("one", my_value==1)) { my_value = 1; }
---@param ctx ImGui_Context
---@param label string
---@param active boolean
---@return boolean 
function reaper.ImGui_RadioButton(ctx, label, active) end

---Shortcut to handle RadioButton's example pattern when value is an integer
---@param ctx ImGui_Context
---@param label string
---@param v integer
---@param v_button integer
---@return boolean retval, integer v
function reaper.ImGui_RadioButtonEx(ctx, label, v, v_button) end

---@param ctx ImGui_Context
---@param button? integer
function reaper.ImGui_ResetMouseDragDelta(ctx, button) end

---Call between widgets or groups to layout them horizontally.
---X position given in window coordinates.
---@param ctx ImGui_Context
---@param offset_from_start_x? number
---@param spacing? number
function reaper.ImGui_SameLine(ctx, offset_from_start_x, spacing) end

---@param ctx ImGui_Context
---@param label string
---@param p_selected boolean
---@param flags? integer
---@param size_w? number
---@param size_h? number
---@return boolean retval, boolean p_selected
function reaper.ImGui_Selectable(ctx, label, p_selected, flags, size_w, size_h) end

---Generate press events on double clicks too.
---@return integer retval
function reaper.ImGui_SelectableFlags_AllowDoubleClick() end

---Hit testing to allow subsequent widgets to overlap this one.
---@return integer retval
function reaper.ImGui_SelectableFlags_AllowItemOverlap() end

---Cannot be selected, display grayed out text.
---@return integer retval
function reaper.ImGui_SelectableFlags_Disabled() end

---Clicking this doesn't close parent popup window.
---@return integer retval
function reaper.ImGui_SelectableFlags_DontClosePopups() end

---@return integer retval
function reaper.ImGui_SelectableFlags_None() end

---Selectable frame can span all columns (text will still fit in current column).
---@return integer retval
function reaper.ImGui_SelectableFlags_SpanAllColumns() end

---Separator, generally horizontal. inside a menu bar or in horizontal layout
---mode, this becomes a vertical separator.
---@param ctx ImGui_Context
function reaper.ImGui_Separator(ctx) end

---Text formatted with an horizontal line
---@param ctx ImGui_Context
---@param label string
function reaper.ImGui_SeparatorText(ctx, label) end

---See also the LogToClipboard function to capture GUI into clipboard,
---or easily output text data to the clipboard.
---@param ctx ImGui_Context
---@param text string
function reaper.ImGui_SetClipboardText(ctx, text) end

---Picker type, etc. User will be able to change many settings, unless you pass
---the _NoOptions flag to your calls.
---@param ctx ImGui_Context
---@param flags integer
function reaper.ImGui_SetColorEditOptions(ctx, flags) end

---@param ctx ImGui_Context
---@param var_idx integer
---@param value number
function reaper.ImGui_SetConfigVar(ctx, var_idx, value) end

---Cursor position in window
---@param ctx ImGui_Context
---@param local_pos_x number
---@param local_pos_y number
function reaper.ImGui_SetCursorPos(ctx, local_pos_x, local_pos_y) end

---Cursor X position in window
---@param ctx ImGui_Context
---@param local_x number
function reaper.ImGui_SetCursorPosX(ctx, local_x) end

---Cursor Y position in window
---@param ctx ImGui_Context
---@param local_y number
function reaper.ImGui_SetCursorPosY(ctx, local_y) end

---Cursor position in absolute screen coordinates.
---@param ctx ImGui_Context
---@param pos_x number
---@param pos_y number
function reaper.ImGui_SetCursorScreenPos(ctx, pos_x, pos_y) end

---The type is a user defined string of maximum 32 characters.
---Strings starting with '_' are reserved for dear imgui internal types.
---Data is copied and held by imgui.
---@param ctx ImGui_Context
---@param type string
---@param data string
---@param cond? integer
---@return boolean 
function reaper.ImGui_SetDragDropPayload(ctx, type, data, cond) end

---Allow last item to be overlapped by a subsequent item. sometimes useful with
---invisible buttons, selectables, etc. to catch unused area.
---@param ctx ImGui_Context
function reaper.ImGui_SetItemAllowOverlap(ctx) end

---Make last item the default focused item of a window.
---@param ctx ImGui_Context
function reaper.ImGui_SetItemDefaultFocus(ctx) end

---Focus keyboard on the next widget. Use positive 'offset' to access sub
---components of a multiple component widget. Use -1 to access previous widget.
---@param ctx ImGui_Context
---@param offset? integer
function reaper.ImGui_SetKeyboardFocusHere(ctx, offset) end

---Set desired mouse cursor shape. See MouseCursor_* for possible values.
---@param ctx ImGui_Context
---@param cursor_type integer
function reaper.ImGui_SetMouseCursor(ctx, cursor_type) end

---Request capture of keyboard shortcuts in REAPER's global scope for the next frame.
---@param ctx ImGui_Context
---@param want_capture_keyboard boolean
function reaper.ImGui_SetNextFrameWantCaptureKeyboard(ctx, want_capture_keyboard) end

---Set next TreeNode/CollapsingHeader open state.
---Can also be done with the TreeNodeFlags_DefaultOpen flag.
---@param ctx ImGui_Context
---@param is_open boolean
---@param cond? integer
function reaper.ImGui_SetNextItemOpen(ctx, is_open, cond) end

---Set width of the _next_ common large "item+label" widget.- \&gt;0.0: width in pixels
---- &lt;0.0 align xx pixels to the right of window
---  (so -FLT_MIN always align width to the right side)
---@param ctx ImGui_Context
---@param item_width number
function reaper.ImGui_SetNextItemWidth(ctx, item_width) end

---Set next window background color alpha. Helper to easily override the Alpha
---component of Col_WindowBg/Col_ChildBg/Col_PopupBg.
---You may also use WindowFlags_NoBackground for a fully transparent window.
---@param ctx ImGui_Context
---@param alpha number
function reaper.ImGui_SetNextWindowBgAlpha(ctx, alpha) end

---Set next window collapsed state.
---@param ctx ImGui_Context
---@param collapsed boolean
---@param cond? integer
function reaper.ImGui_SetNextWindowCollapsed(ctx, collapsed, cond) end

---Set next window content size (~ scrollable client area, which enforce the
---range of scrollbars). Not including window decorations (title bar, menu bar,
---etc.) nor StyleVar_WindowPadding. set an axis to 0.0 to leave it automatic.
---@param ctx ImGui_Context
---@param size_w number
---@param size_h number
function reaper.ImGui_SetNextWindowContentSize(ctx, size_w, size_h) end

---@param ctx ImGui_Context
---@param dock_id integer
---@param cond? integer
function reaper.ImGui_SetNextWindowDockID(ctx, dock_id, cond) end

---Set next window to be focused / top-most.
---@param ctx ImGui_Context
function reaper.ImGui_SetNextWindowFocus(ctx) end

---Set next window position. Use pivot=(0.5,0.5) to center on given point, etc.
---@param ctx ImGui_Context
---@param pos_x number
---@param pos_y number
---@param cond? integer
---@param pivot_x? number
---@param pivot_y? number
function reaper.ImGui_SetNextWindowPos(ctx, pos_x, pos_y, cond, pivot_x, pivot_y) end

---Set next window scrolling value (use &lt; 0.0 to not affect a given axis).
---@param ctx ImGui_Context
---@param scroll_x number
---@param scroll_y number
function reaper.ImGui_SetNextWindowScroll(ctx, scroll_x, scroll_y) end

---Set next window size. set axis to 0.0 to force an auto-fit on this axis.
---@param ctx ImGui_Context
---@param size_w number
---@param size_h number
---@param cond? integer
function reaper.ImGui_SetNextWindowSize(ctx, size_w, size_h, cond) end

---Set next window size limits. Use -1,-1 on either X/Y axis to preserve the
---current size. Use FLT_MAX (second return value of NumericLimits_Float) for no
---maximum size. Sizes will be rounded down.
---@param ctx ImGui_Context
---@param size_min_w number
---@param size_min_h number
---@param size_max_w number
---@param callback? number
function reaper.ImGui_SetNextWindowSizeConstraints(ctx, size_min_w, size_min_h, size_max_w, callback) end

---Adjust scrolling amount to make given position visible.
---Generally GetCursorStartPos() + offset to compute a valid position.
---@param ctx ImGui_Context
---@param local_x number
---@param center_x_ratio? number
function reaper.ImGui_SetScrollFromPosX(ctx, local_x, center_x_ratio) end

---Adjust scrolling amount to make given position visible.
---Generally GetCursorStartPos() + offset to compute a valid position.
---@param ctx ImGui_Context
---@param local_y number
---@param center_y_ratio? number
function reaper.ImGui_SetScrollFromPosY(ctx, local_y, center_y_ratio) end

---Adjust scrolling amount to make current cursor position visible.
---center_x_ratio=0.0: left, 0.5: center, 1.0: right.
---When using to make a "default/current item" visible,
---consider using SetItemDefaultFocus instead.
---@param ctx ImGui_Context
---@param center_x_ratio? number
function reaper.ImGui_SetScrollHereX(ctx, center_x_ratio) end

---Adjust scrolling amount to make current cursor position visible.
---center_y_ratio=0.0: top, 0.5: center, 1.0: bottom.
---When using to make a "default/current item" visible,
---consider using SetItemDefaultFocus instead.
---@param ctx ImGui_Context
---@param center_y_ratio? number
function reaper.ImGui_SetScrollHereY(ctx, center_y_ratio) end

---Set scrolling amount [0 .. GetScrollMaxX()]
---@param ctx ImGui_Context
---@param scroll_x number
function reaper.ImGui_SetScrollX(ctx, scroll_x) end

---Set scrolling amount [0 .. GetScrollMaxY()]
---@param ctx ImGui_Context
---@param scroll_y number
function reaper.ImGui_SetScrollY(ctx, scroll_y) end

---Notify TabBar or Docking system of a closed tab/window ahead
---(useful to reduce visual flicker on reorderable tab bars).
---For tab-bar: call after BeginTabBar and before Tab submissions.
---Otherwise call with a window name.
---@param ctx ImGui_Context
---@param tab_or_docked_window_label string
function reaper.ImGui_SetTabItemClosed(ctx, tab_or_docked_window_label) end

---Set a text-only tooltip, typically use with IsItemHovered. override any
---previous call to SetTooltip.
---@param ctx ImGui_Context
---@param text string
function reaper.ImGui_SetTooltip(ctx, text) end

---(Not recommended) Set current window collapsed state.
---Prefer using SetNextWindowCollapsed.
---@param ctx ImGui_Context
---@param collapsed boolean
---@param cond? integer
function reaper.ImGui_SetWindowCollapsed(ctx, collapsed, cond) end

---Set named window collapsed state.
---@param ctx ImGui_Context
---@param name string
---@param collapsed boolean
---@param cond? integer
function reaper.ImGui_SetWindowCollapsedEx(ctx, name, collapsed, cond) end

---(Not recommended) Set current window to be focused / top-most.
---Prefer using SetNextWindowFocus.
---@param ctx ImGui_Context
function reaper.ImGui_SetWindowFocus(ctx) end

---Set named window to be focused / top-most. Use an empty name to remove focus.
---@param ctx ImGui_Context
---@param name string
function reaper.ImGui_SetWindowFocusEx(ctx, name) end

---(Not recommended) Set current window position - call within Begin/End.
---Prefer using SetNextWindowPos, as this may incur tearing and minor side-effects.
---@param ctx ImGui_Context
---@param pos_x number
---@param pos_y number
---@param cond? integer
function reaper.ImGui_SetWindowPos(ctx, pos_x, pos_y, cond) end

---Set named window position.
---@param ctx ImGui_Context
---@param name string
---@param pos_x number
---@param pos_y number
---@param cond? integer
function reaper.ImGui_SetWindowPosEx(ctx, name, pos_x, pos_y, cond) end

---(Not recommended) Set current window size - call within Begin/End.
---Set size_w and size_h to 0 to force an auto-fit.
---Prefer using SetNextWindowSize, as this may incur tearing and minor side-effects.
---@param ctx ImGui_Context
---@param size_w number
---@param size_h number
---@param cond? integer
function reaper.ImGui_SetWindowSize(ctx, size_w, size_h, cond) end

---Set named window size. Set axis to 0.0 to force an auto-fit on this axis.
---@param ctx ImGui_Context
---@param name string
---@param size_w number
---@param size_h number
---@param cond? integer
function reaper.ImGui_SetWindowSizeEx(ctx, name, size_w, size_h, cond) end

---Create About window.
---Display ReaImGui version, Dear ImGui version, credits and build/system information.
---@param ctx ImGui_Context
---@param p_open? boolean
---@return boolean|nil p_open
function reaper.ImGui_ShowAboutWindow(ctx, p_open) end

---Create Debug Log window. display a simplified log of important dear imgui events.
---@param ctx ImGui_Context
---@param p_open? boolean
---@return boolean|nil p_open
function reaper.ImGui_ShowDebugLogWindow(ctx, p_open) end

---Create Metrics/Debugger window.
---Display Dear ImGui internals: windows, draw commands, various internal state, etc.
---@param ctx ImGui_Context
---@param p_open? boolean
---@return boolean|nil p_open
function reaper.ImGui_ShowMetricsWindow(ctx, p_open) end

---Create Stack Tool window. Hover items with mouse to query information about
---the source of their unique ID.
---@param ctx ImGui_Context
---@param p_open? boolean
---@return boolean|nil p_open
function reaper.ImGui_ShowStackToolWindow(ctx, p_open) end

---@param ctx ImGui_Context
---@param label string
---@param v_rad number
---@param v_degrees_min? number
---@param v_degrees_max? number
---@param format? string
---@param flags? integer
---@return boolean retval, number v_rad
function reaper.ImGui_SliderAngle(ctx, label, v_rad, v_degrees_min, v_degrees_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v number
---@param v_min number
---@param v_max number
---@param format? string
---@param flags? integer
---@return boolean retval, number v
function reaper.ImGui_SliderDouble(ctx, label, v, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 number
---@param v2 number
---@param v_min number
---@param v_max number
---@param format? string
---@param flags? integer
---@return boolean retval, number v1, number v2
function reaper.ImGui_SliderDouble2(ctx, label, v1, v2, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 number
---@param v2 number
---@param v3 number
---@param v_min number
---@param v_max number
---@param format? string
---@param flags? integer
---@return boolean retval, number v1, number v2, number v3
function reaper.ImGui_SliderDouble3(ctx, label, v1, v2, v3, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 number
---@param v2 number
---@param v3 number
---@param v4 number
---@param v_min number
---@param v_max number
---@param format? string
---@param flags? integer
---@return boolean retval, number v1, number v2, number v3, number v4
function reaper.ImGui_SliderDouble4(ctx, label, v1, v2, v3, v4, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param values? string
---@param v_min number
---@param v_max number
---@param format? string
---@param flags? integer
---@return boolean 
function reaper.ImGui_SliderDoubleN(ctx, values, v_min, v_max, format, flags) end

---Clamp value to min/max bounds when input manually with CTRL+Click.
---   By default CTRL+Click allows going out of bounds.
---@return integer retval
function reaper.ImGui_SliderFlags_AlwaysClamp() end

---Make the widget logarithmic (linear otherwise).
---   Consider using SliderFlags_NoRoundToFormat with this if using a format-string
---   with small amount of digits.
---@return integer retval
function reaper.ImGui_SliderFlags_Logarithmic() end

---Disable CTRL+Click or Enter key allowing to input text directly into the widget.
---@return integer retval
function reaper.ImGui_SliderFlags_NoInput() end

---Disable rounding underlying value to match precision of the display format
---   string (e.g. %.3f values are rounded to those 3 digits).
---@return integer retval
function reaper.ImGui_SliderFlags_NoRoundToFormat() end

---@return integer retval
function reaper.ImGui_SliderFlags_None() end

---@param ctx ImGui_Context
---@param label string
---@param v integer
---@param v_min integer
---@param v_max integer
---@param format? string
---@param flags? integer
---@return boolean retval, integer v
function reaper.ImGui_SliderInt(ctx, label, v, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 integer
---@param v2 integer
---@param v_min integer
---@param v_max integer
---@param format? string
---@param flags? integer
---@return boolean retval, integer v1, integer v2
function reaper.ImGui_SliderInt2(ctx, label, v1, v2, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 integer
---@param v2 integer
---@param v3 integer
---@param v_min integer
---@param v_max integer
---@param format? string
---@param flags? integer
---@return boolean retval, integer v1, integer v2, integer v3
function reaper.ImGui_SliderInt3(ctx, label, v1, v2, v3, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param v1 integer
---@param v2 integer
---@param v3 integer
---@param v4 integer
---@param v_min integer
---@param v_max integer
---@param format? string
---@param flags? integer
---@return boolean retval, integer v1, integer v2, integer v3, integer v4
function reaper.ImGui_SliderInt4(ctx, label, v1, v2, v3, v4, v_min, v_max, format, flags) end

---Button with StyleVar_FramePadding=(0,0) to easily embed within text.
---@param ctx ImGui_Context
---@param label string
---@return boolean 
function reaper.ImGui_SmallButton(ctx, label) end

---Ascending = 0-&gt;9, A-&gt;Z etc.
---@return integer retval
function reaper.ImGui_SortDirection_Ascending() end

---Descending = 9-&gt;0, Z-&gt;A etc.
---@return integer retval
function reaper.ImGui_SortDirection_Descending() end

---@return integer retval
function reaper.ImGui_SortDirection_None() end

---Add vertical spacing.
---@param ctx ImGui_Context
function reaper.ImGui_Spacing(ctx) end

---Global alpha applies to everything in Dear ImGui.
---@return integer retval
function reaper.ImGui_StyleVar_Alpha() end

---Alignment of button text when button is larger than text.
---   Defaults to (0.5, 0.5) (centered).
---@return integer retval
function reaper.ImGui_StyleVar_ButtonTextAlign() end

---Padding within a table cell.
---@return integer retval
function reaper.ImGui_StyleVar_CellPadding() end

---Thickness of border around child windows. Generally set to 0.0 or 1.0.
---   (Other values are not well tested and more CPU/GPU costly).
---@return integer retval
function reaper.ImGui_StyleVar_ChildBorderSize() end

---Radius of child window corners rounding. Set to 0.0 to have rectangular windows.
---@return integer retval
function reaper.ImGui_StyleVar_ChildRounding() end

---Additional alpha multiplier applied by BeginDisabled.
---  Multiply over current value of Alpha.
---@return integer retval
function reaper.ImGui_StyleVar_DisabledAlpha() end

---Thickness of border around frames. Generally set to 0.0 or 1.0.
---   (Other values are not well tested and more CPU/GPU costly).
---@return integer retval
function reaper.ImGui_StyleVar_FrameBorderSize() end

---Padding within a framed rectangle (used by most widgets).
---@return integer retval
function reaper.ImGui_StyleVar_FramePadding() end

---Radius of frame corners rounding.
---   Set to 0.0 to have rectangular frame (used by most widgets).
---@return integer retval
function reaper.ImGui_StyleVar_FrameRounding() end

---Minimum width/height of a grab box for slider/scrollbar.
---@return integer retval
function reaper.ImGui_StyleVar_GrabMinSize() end

---Radius of grabs corners rounding. Set to 0.0 to have rectangular slider grabs.
---@return integer retval
function reaper.ImGui_StyleVar_GrabRounding() end

---Horizontal indentation when e.g. entering a tree node.
---   Generally == (GetFontSize + StyleVar_FramePadding.x*2).
---@return integer retval
function reaper.ImGui_StyleVar_IndentSpacing() end

---Horizontal and vertical spacing between within elements of a composed widget
---   (e.g. a slider and its label).
---@return integer retval
function reaper.ImGui_StyleVar_ItemInnerSpacing() end

---Horizontal and vertical spacing between widgets/lines.
---@return integer retval
function reaper.ImGui_StyleVar_ItemSpacing() end

---Thickness of border around popup/tooltip windows. Generally set to 0.0 or 1.0.
---   (Other values are not well tested and more CPU/GPU costly).
---@return integer retval
function reaper.ImGui_StyleVar_PopupBorderSize() end

---Radius of popup window corners rounding.
---   (Note that tooltip windows use StyleVar_WindowRounding.)
---@return integer retval
function reaper.ImGui_StyleVar_PopupRounding() end

---Radius of grab corners for scrollbar.
---@return integer retval
function reaper.ImGui_StyleVar_ScrollbarRounding() end

---Width of the vertical scrollbar, Height of the horizontal scrollbar.
---@return integer retval
function reaper.ImGui_StyleVar_ScrollbarSize() end

---Alignment of selectable text. Defaults to (0.0, 0.0) (top-left aligned).
---   It's generally important to keep this left-aligned if you want to lay
---   multiple items on a same line.
---@return integer retval
function reaper.ImGui_StyleVar_SelectableTextAlign() end

---Alignment of text within the separator.
---Defaults to (0.0, 0.5) (left aligned, center).
---@return integer retval
function reaper.ImGui_StyleVar_SeparatorTextAlign() end

---Thickness of border in SeparatorText()
---@return integer retval
function reaper.ImGui_StyleVar_SeparatorTextBorderSize() end

---Horizontal offset of text from each edge of the separator + spacing on other
---axis. Generally small values. .y is recommended to be == StyleVar_FramePadding.y.
---@return integer retval
function reaper.ImGui_StyleVar_SeparatorTextPadding() end

---Radius of upper corners of a tab. Set to 0.0 to have rectangular tabs.
---@return integer retval
function reaper.ImGui_StyleVar_TabRounding() end

---Thickness of border around windows. Generally set to 0.0 or 1.0.
---  (Other values are not well tested and more CPU/GPU costly).
---@return integer retval
function reaper.ImGui_StyleVar_WindowBorderSize() end

---Minimum window size. This is a global setting.
---  If you want to constrain individual windows, use SetNextWindowSizeConstraints.
---@return integer retval
function reaper.ImGui_StyleVar_WindowMinSize() end

---Padding within a window.
---@return integer retval
function reaper.ImGui_StyleVar_WindowPadding() end

---Radius of window corners rounding. Set to 0.0 to have rectangular windows.
---  Large values tend to lead to variety of artifacts and are not recommended.
---@return integer retval
function reaper.ImGui_StyleVar_WindowRounding() end

---Alignment for title bar text.
---   Defaults to (0.0,0.5) for left-aligned,vertically centered.
---@return integer retval
function reaper.ImGui_StyleVar_WindowTitleAlign() end

---Automatically select new tabs when they appear.
---@return integer retval
function reaper.ImGui_TabBarFlags_AutoSelectNewTabs() end

---Resize tabs when they don't fit.
---@return integer retval
function reaper.ImGui_TabBarFlags_FittingPolicyResizeDown() end

---Add scroll buttons when tabs don't fit.
---@return integer retval
function reaper.ImGui_TabBarFlags_FittingPolicyScroll() end

---Disable behavior of closing tabs (that are submitted with p_open != nil)
---   with middle mouse button. You can still repro this behavior on user's side
---   with if(IsItemHovered() &amp;&amp; IsMouseClicked(2)) p_open = false.
---@return integer retval
function reaper.ImGui_TabBarFlags_NoCloseWithMiddleMouseButton() end

---Disable scrolling buttons (apply when fitting policy is
---   TabBarFlags_FittingPolicyScroll).
---@return integer retval
function reaper.ImGui_TabBarFlags_NoTabListScrollingButtons() end

---Disable tooltips when hovering a tab.
---@return integer retval
function reaper.ImGui_TabBarFlags_NoTooltip() end

---@return integer retval
function reaper.ImGui_TabBarFlags_None() end

---Allow manually dragging tabs to re-order them + New tabs are appended at
---   the end of list.
---@return integer retval
function reaper.ImGui_TabBarFlags_Reorderable() end

---Disable buttons to open the tab list popup.
---@return integer retval
function reaper.ImGui_TabBarFlags_TabListPopupButton() end

---Create a Tab behaving like a button. Return true when clicked.
---Cannot be selected in the tab bar.
---@param ctx ImGui_Context
---@param label string
---@param flags? integer
---@return boolean 
function reaper.ImGui_TabItemButton(ctx, label, flags) end

---Enforce the tab position to the left of the tab bar (after the tab list popup button).
---@return integer retval
function reaper.ImGui_TabItemFlags_Leading() end

---Disable behavior of closing tabs (that are submitted with p_open != nil) with
---   middle mouse button. You can still repro this behavior on user's side with
---   if(IsItemHovered() &amp;&amp; IsMouseClicked(2)) p_open = false.
---@return integer retval
function reaper.ImGui_TabItemFlags_NoCloseWithMiddleMouseButton() end

---Don't call PushID(tab-&gt;ID)/PopID() on BeginTabItem/EndTabItem.
---@return integer retval
function reaper.ImGui_TabItemFlags_NoPushId() end

---Disable reordering this tab or having another tab cross over this tab.
---@return integer retval
function reaper.ImGui_TabItemFlags_NoReorder() end

---Disable tooltip for the given tab.
---@return integer retval
function reaper.ImGui_TabItemFlags_NoTooltip() end

---@return integer retval
function reaper.ImGui_TabItemFlags_None() end

---Trigger flag to programmatically make the tab selected when calling BeginTabItem.
---@return integer retval
function reaper.ImGui_TabItemFlags_SetSelected() end

---Enforce the tab position to the right of the tab bar (before the scrolling buttons).
---@return integer retval
function reaper.ImGui_TabItemFlags_Trailing() end

---Append '*' to title without affecting the ID, as a convenience to avoid using
---   the ### operator. Also: tab is selected on closure and closure is deferred by
---   one frame to allow code to undo it without flicker.
---@return integer retval
function reaper.ImGui_TabItemFlags_UnsavedDocument() end

---Set cell background color (top-most color).
---@return integer retval
function reaper.ImGui_TableBgTarget_CellBg() end

---@return integer retval
function reaper.ImGui_TableBgTarget_None() end

---Set row background color 0 (generally used for background,
---   automatically set when TableFlags_RowBg is used).
---@return integer retval
function reaper.ImGui_TableBgTarget_RowBg0() end

---Set row background color 1 (generally used for selection marking).
---@return integer retval
function reaper.ImGui_TableBgTarget_RowBg1() end

---Default as a hidden/disabled column.
---@return integer retval
function reaper.ImGui_TableColumnFlags_DefaultHide() end

---Default as a sorting column.
---@return integer retval
function reaper.ImGui_TableColumnFlags_DefaultSort() end

---Overriding/master disable flag: hide column, won't show in context menu
---   (unlike calling TableSetColumnEnabled which manipulates the user accessible state).
---@return integer retval
function reaper.ImGui_TableColumnFlags_Disabled() end

---Ignore current Indent value when entering cell (default for columns &gt; 0).
---   Indentation changes _within_ the cell will still be honored.
---@return integer retval
function reaper.ImGui_TableColumnFlags_IndentDisable() end

---Use current Indent value when entering cell (default for column 0).
---@return integer retval
function reaper.ImGui_TableColumnFlags_IndentEnable() end

---Status: is enabled == not hidden by user/api (referred to as "Hide" in
---   _DefaultHide and _NoHide) flags.
---@return integer retval
function reaper.ImGui_TableColumnFlags_IsEnabled() end

---Status: is hovered by mouse.
---@return integer retval
function reaper.ImGui_TableColumnFlags_IsHovered() end

---Status: is currently part of the sort specs.
---@return integer retval
function reaper.ImGui_TableColumnFlags_IsSorted() end

---Status: is visible == is enabled AND not clipped by scrolling.
---@return integer retval
function reaper.ImGui_TableColumnFlags_IsVisible() end

---Disable clipping for this column
---   (all NoClip columns will render in a same draw command).
---@return integer retval
function reaper.ImGui_TableColumnFlags_NoClip() end

---TableHeadersRow will not submit label for this column.
---   Convenient for some small columns. Name will still appear in context menu.
---@return integer retval
function reaper.ImGui_TableColumnFlags_NoHeaderLabel() end

---Disable header text width contribution to automatic column width.
---@return integer retval
function reaper.ImGui_TableColumnFlags_NoHeaderWidth() end

---Disable ability to hide/disable this column.
---@return integer retval
function reaper.ImGui_TableColumnFlags_NoHide() end

---Disable manual reordering this column, this will also prevent other columns
---   from crossing over this column.
---@return integer retval
function reaper.ImGui_TableColumnFlags_NoReorder() end

---Disable manual resizing.
---@return integer retval
function reaper.ImGui_TableColumnFlags_NoResize() end

---Disable ability to sort on this field
---   (even if TableFlags_Sortable is set on the table).
---@return integer retval
function reaper.ImGui_TableColumnFlags_NoSort() end

---Disable ability to sort in the ascending direction.
---@return integer retval
function reaper.ImGui_TableColumnFlags_NoSortAscending() end

---Disable ability to sort in the descending direction.
---@return integer retval
function reaper.ImGui_TableColumnFlags_NoSortDescending() end

---@return integer retval
function reaper.ImGui_TableColumnFlags_None() end

---Make the initial sort direction Ascending when first sorting on this column (default).
---@return integer retval
function reaper.ImGui_TableColumnFlags_PreferSortAscending() end

---Make the initial sort direction Descending when first sorting on this column.
---@return integer retval
function reaper.ImGui_TableColumnFlags_PreferSortDescending() end

---Column will not stretch. Preferable with horizontal scrolling enabled
---   (default if table sizing policy is _SizingFixedFit and table is resizable).
---@return integer retval
function reaper.ImGui_TableColumnFlags_WidthFixed() end

---Column will stretch. Preferable with horizontal scrolling disabled
---   (default if table sizing policy is _SizingStretchSame or _SizingStretchProp).
---@return integer retval
function reaper.ImGui_TableColumnFlags_WidthStretch() end

---Draw all borders.
---@return integer retval
function reaper.ImGui_TableFlags_Borders() end

---Draw horizontal borders.
---@return integer retval
function reaper.ImGui_TableFlags_BordersH() end

---Draw inner borders.
---@return integer retval
function reaper.ImGui_TableFlags_BordersInner() end

---Draw horizontal borders between rows.
---@return integer retval
function reaper.ImGui_TableFlags_BordersInnerH() end

---Draw vertical borders between columns.
---@return integer retval
function reaper.ImGui_TableFlags_BordersInnerV() end

---Draw outer borders.
---@return integer retval
function reaper.ImGui_TableFlags_BordersOuter() end

---Draw horizontal borders at the top and bottom.
---@return integer retval
function reaper.ImGui_TableFlags_BordersOuterH() end

---Draw vertical borders on the left and right sides.
---@return integer retval
function reaper.ImGui_TableFlags_BordersOuterV() end

---Draw vertical borders.
---@return integer retval
function reaper.ImGui_TableFlags_BordersV() end

---Right-click on columns body/contents will display table context menu.
---   By default it is available in TableHeadersRow.
---@return integer retval
function reaper.ImGui_TableFlags_ContextMenuInBody() end

---Enable hiding/disabling columns in context menu.
---@return integer retval
function reaper.ImGui_TableFlags_Hideable() end

---Disable clipping rectangle for every individual columns
---   (reduce draw command count, items will be able to overflow into other columns).
---   Generally incompatible with TableSetupScrollFreeze.
---@return integer retval
function reaper.ImGui_TableFlags_NoClip() end

---Make outer width auto-fit to columns, overriding outer_size.x value. Only
---   available when ScrollX/ScrollY are disabled and Stretch columns are not used.
---@return integer retval
function reaper.ImGui_TableFlags_NoHostExtendX() end

---Make outer height stop exactly at outer_size.y (prevent auto-extending table
---   past the limit). Only available when ScrollX/ScrollY are disabled.
---   Data below the limit will be clipped and not visible.
---@return integer retval
function reaper.ImGui_TableFlags_NoHostExtendY() end

---Disable keeping column always minimally visible when ScrollX is off and table
---   gets too small. Not recommended if columns are resizable.
---@return integer retval
function reaper.ImGui_TableFlags_NoKeepColumnsVisible() end

---Disable inner padding between columns (double inner padding if
---   TableFlags_BordersOuterV is on, single inner padding if BordersOuterV is off).
---@return integer retval
function reaper.ImGui_TableFlags_NoPadInnerX() end

---Default if TableFlags_BordersOuterV is off. Disable outermost padding.
---@return integer retval
function reaper.ImGui_TableFlags_NoPadOuterX() end

---Disable persisting columns order, width and sort settings in the .ini file.
---@return integer retval
function reaper.ImGui_TableFlags_NoSavedSettings() end

---@return integer retval
function reaper.ImGui_TableFlags_None() end

---Default if TableFlags_BordersOuterV is on. Enable outermost padding.
---   Generally desirable if you have headers.
---@return integer retval
function reaper.ImGui_TableFlags_PadOuterX() end

---Disable distributing remainder width to stretched columns (width allocation
---   on a 100-wide table with 3 columns: Without this flag: 33,33,34. With this
---   flag: 33,33,33).
---   With larger number of columns, resizing will appear to be less smooth.
---@return integer retval
function reaper.ImGui_TableFlags_PreciseWidths() end

---Enable reordering columns in header row
---   (need calling TableSetupColumn + TableHeadersRow to display headers).
---@return integer retval
function reaper.ImGui_TableFlags_Reorderable() end

---Enable resizing columns.
---@return integer retval
function reaper.ImGui_TableFlags_Resizable() end

---Set each RowBg color with Col_TableRowBg or Col_TableRowBgAlt (equivalent of
---   calling TableSetBgColor with TableBgTarget_RowBg0 on each row manually).
---@return integer retval
function reaper.ImGui_TableFlags_RowBg() end

---Enable horizontal scrolling. Require 'outer_size' parameter of BeginTable to
---   specify the container size. Changes default sizing policy.
---   Because this creates a child window, ScrollY is currently generally
---   recommended when using ScrollX.
---@return integer retval
function reaper.ImGui_TableFlags_ScrollX() end

---Enable vertical scrolling.
---   Require 'outer_size' parameter of BeginTable to specify the container size.
---@return integer retval
function reaper.ImGui_TableFlags_ScrollY() end

---Columns default to _WidthFixed or _WidthAuto (if resizable or not resizable),
---   matching contents width.
---@return integer retval
function reaper.ImGui_TableFlags_SizingFixedFit() end

---Columns default to _WidthFixed or _WidthAuto (if resizable or not resizable),
---   matching the maximum contents width of all columns.
---   Implicitly enable TableFlags_NoKeepColumnsVisible.
---@return integer retval
function reaper.ImGui_TableFlags_SizingFixedSame() end

---Columns default to _WidthStretch with default weights proportional to each
---   columns contents widths.
---@return integer retval
function reaper.ImGui_TableFlags_SizingStretchProp() end

---Columns default to _WidthStretch with default weights all equal,
---   unless overriden by TableSetupColumn.
---@return integer retval
function reaper.ImGui_TableFlags_SizingStretchSame() end

---Hold shift when clicking headers to sort on multiple column.
---   TableGetGetSortSpecs may return specs where (SpecsCount &gt; 1).
---@return integer retval
function reaper.ImGui_TableFlags_SortMulti() end

---Allow no sorting, disable default sorting.
---   TableGetColumnSortSpecs may return specs where (SpecsCount == 0).
---@return integer retval
function reaper.ImGui_TableFlags_SortTristate() end

---Enable sorting. Call TableNeedSort/TableGetColumnSortSpecs to obtain sort specs.
---   Also see TableFlags_SortMulti and TableFlags_SortTristate.
---@return integer retval
function reaper.ImGui_TableFlags_Sortable() end

---Return number of columns (value passed to BeginTable).
---@param ctx ImGui_Context
---@return integer retval
function reaper.ImGui_TableGetColumnCount(ctx) end

---Return column flags so you can query their Enabled/Visible/Sorted/Hovered
---status flags. Pass -1 to use current column.
---@param ctx ImGui_Context
---@param column_n? integer
---@return integer retval
function reaper.ImGui_TableGetColumnFlags(ctx, column_n) end

---Return current column index.
---@param ctx ImGui_Context
---@return integer retval
function reaper.ImGui_TableGetColumnIndex(ctx) end

---Return "" if column didn't have a name declared by TableSetupColumn.
---Pass -1 to use current column.
---@param ctx ImGui_Context
---@param column_n? integer
---@return string retval
function reaper.ImGui_TableGetColumnName(ctx, column_n) end

---Sorting specification for one column of a table.
---Call while incrementing 'id' from 0 until false is returned.- ColumnUserID:  User id of the column (if specified by a TableSetupColumn call)
---- ColumnIndex:   Index of the column
---- SortOrder:     Index within parent SortSpecs (always stored in order starting
---  from 0, tables sorted on a single criteria will always have a 0 here)
---- SortDirection: SortDirection_Ascending or SortDirection_Descending
---  (you can use this or SortSign, whichever is more convenient for your sort
---  function)See TableNeedSort.
---@param ctx ImGui_Context
---@param id integer
---@return boolean retval, integer column_user_id, integer column_index, integer sort_order, integer sort_direction
function reaper.ImGui_TableGetColumnSortSpecs(ctx, id) end

---Return current row index.
---@param ctx ImGui_Context
---@return integer retval
function reaper.ImGui_TableGetRowIndex(ctx) end

---Submit one header cell manually (rarely used). See TableSetupColumn.
---@param ctx ImGui_Context
---@param label string
function reaper.ImGui_TableHeader(ctx, label) end

---Submit all headers cells based on data provided to TableSetupColumn +
---submit context menu.
---@param ctx ImGui_Context
function reaper.ImGui_TableHeadersRow(ctx) end

---Return true once when sorting specs have changed since last call,
---or the first time. 'has_specs' is false when not sorting.See TableGetColumnSortSpecs.
---@param ctx ImGui_Context
---@return boolean retval, boolean has_specs
function reaper.ImGui_TableNeedSort(ctx) end

---Append into the next column (or first column of next row if currently in
---last column). Return true when column is visible.
---@param ctx ImGui_Context
---@return boolean 
function reaper.ImGui_TableNextColumn(ctx) end

---Append into the first cell of a new row.
---@param ctx ImGui_Context
---@param row_flags? integer
---@param min_row_height? number
function reaper.ImGui_TableNextRow(ctx, row_flags, min_row_height) end

---Identify header row (set default background color + width of its contents
---   accounted different for auto column width).
---@return integer retval
function reaper.ImGui_TableRowFlags_Headers() end

---For TableNextRow.
---@return integer retval
function reaper.ImGui_TableRowFlags_None() end

---Change the color of a cell, row, or column.
---See TableBgTarget_* flags for details.
---@param ctx ImGui_Context
---@param target integer
---@param color_rgba integer
---@param column_n? integer
function reaper.ImGui_TableSetBgColor(ctx, target, color_rgba, column_n) end

---Change user-accessible enabled/disabled state of a column, set to false to
---hide the column. Note that end-user can use the context menu to change this
---themselves (right-click in headers, or right-click in columns body with
---TableFlags_ContextMenuInBody).- Require table to have the TableFlags_Hideable flag because we are manipulating
---  user accessible state.
---- Request will be applied during next layout, which happens on the first call to
---  TableNextRow after Begin_Table.
---- For the getter you can test
---  (TableGetColumnFlags() &amp; TableColumnFlags_IsEnabled) != 0.
---@param ctx ImGui_Context
---@param column_n integer
---@param v boolean
function reaper.ImGui_TableSetColumnEnabled(ctx, column_n, v) end

---Append into the specified column. Return true when column is visible.
---@param ctx ImGui_Context
---@param column_n integer
---@return boolean 
function reaper.ImGui_TableSetColumnIndex(ctx, column_n) end

---Use to specify label, resizing policy, default width/weight, id,
---various other flags etc.
---@param ctx ImGui_Context
---@param label string
---@param flags? integer
---@param init_width_or_weight? number
---@param user_id? integer
function reaper.ImGui_TableSetupColumn(ctx, label, flags, init_width_or_weight, user_id) end

---Lock columns/rows so they stay visible when scrolled.
---@param ctx ImGui_Context
---@param cols integer
---@param rows integer
function reaper.ImGui_TableSetupScrollFreeze(ctx, cols, rows) end

---@param ctx ImGui_Context
---@param text string
function reaper.ImGui_Text(ctx, text) end

---Shortcut for PushStyleColor(Col_Text, color); Text(text); PopStyleColor();
---@param ctx ImGui_Context
---@param col_rgba integer
---@param text string
function reaper.ImGui_TextColored(ctx, col_rgba, text) end

---@param ctx ImGui_Context
---@param text string
function reaper.ImGui_TextDisabled(ctx, text) end

---@param filter ImGui_TextFilter
function reaper.ImGui_TextFilter_Clear(filter) end

---Helper calling InputText+TextFilter_Set
---@param ctx? ImGui_TextFilter
---@param label? string
---@param width? number
---@return boolean 
function reaper.ImGui_TextFilter_Draw(ctx, label, width) end

---@param filter ImGui_TextFilter
---@return string retval
function reaper.ImGui_TextFilter_Get(filter) end

---@param filter ImGui_TextFilter
---@return boolean 
function reaper.ImGui_TextFilter_IsActive(filter) end

---@param filter ImGui_TextFilter
---@param text string
---@return boolean 
function reaper.ImGui_TextFilter_PassFilter(filter, text) end

---@param filter ImGui_TextFilter
---@param filter_text string
function reaper.ImGui_TextFilter_Set(filter, filter_text) end

---Shortcut for PushTextWrapPos(0.0); Text(text); PopTextWrapPos();.
---Note that this won't work on an auto-resizing window if there's no other
---widgets to extend the window width, yoy may need to set a size using
---SetNextWindowSize.
---@param ctx ImGui_Context
---@param text string
function reaper.ImGui_TextWrapped(ctx, text) end

---TreeNode functions return true when the node is open, in which case you need
---to also call TreePop when you are finished displaying the tree node contents.
---@param ctx ImGui_Context
---@param label string
---@param flags? integer
---@return boolean 
function reaper.ImGui_TreeNode(ctx, label, flags) end

---Helper variation to easily decorelate the id from the displayed string.
---Read the [FAQ](https://dearimgui.org/faq) about why and how to use ID.
---To align arbitrary text at the same level as a TreeNode you can use Bullet.
---@param ctx ImGui_Context
---@param str_id string
---@param label string
---@param flags? integer
---@return boolean 
function reaper.ImGui_TreeNodeEx(ctx, str_id, label, flags) end

---Hit testing to allow subsequent widgets to overlap this one.
---@return integer retval
function reaper.ImGui_TreeNodeFlags_AllowItemOverlap() end

---Display a bullet instead of arrow.
---@return integer retval
function reaper.ImGui_TreeNodeFlags_Bullet() end

---TreeNodeFlags_Framed | TreeNodeFlags_NoTreePushOnOpen | TreeNodeFlags_NoAutoOpenOnLog
---@return integer retval
function reaper.ImGui_TreeNodeFlags_CollapsingHeader() end

---Default node to be open.
---@return integer retval
function reaper.ImGui_TreeNodeFlags_DefaultOpen() end

---Use FramePadding (even for an unframed text node) to vertically align text
---   baseline to regular widget height.
---   Equivalent to calling AlignTextToFramePadding.
---@return integer retval
function reaper.ImGui_TreeNodeFlags_FramePadding() end

---Draw frame with background (e.g. for CollapsingHeader).
---@return integer retval
function reaper.ImGui_TreeNodeFlags_Framed() end

---No collapsing, no arrow (use as a convenience for leaf nodes).
---@return integer retval
function reaper.ImGui_TreeNodeFlags_Leaf() end

---Don't automatically and temporarily open node when Logging is active
---   (by default logging will automatically open tree nodes).
---@return integer retval
function reaper.ImGui_TreeNodeFlags_NoAutoOpenOnLog() end

---Don't do a TreePush when open (e.g. for CollapsingHeader)
---   = no extra indent nor pushing on ID stack.
---@return integer retval
function reaper.ImGui_TreeNodeFlags_NoTreePushOnOpen() end

---@return integer retval
function reaper.ImGui_TreeNodeFlags_None() end

---Only open when clicking on the arrow part.
---   If TreeNodeFlags_OpenOnDoubleClick is also set, single-click arrow or
---   double-click all box to open.
---@return integer retval
function reaper.ImGui_TreeNodeFlags_OpenOnArrow() end

---Need double-click to open node.
---@return integer retval
function reaper.ImGui_TreeNodeFlags_OpenOnDoubleClick() end

---Draw as selected.
---@return integer retval
function reaper.ImGui_TreeNodeFlags_Selected() end

---Extend hit box to the right-most edge, even if not framed.
---   This is not the default in order to allow adding other items on the same line.
---   In the future we may refactor the hit system to be front-to-back,
---   allowing natural overlaps and then this can become the default.
---@return integer retval
function reaper.ImGui_TreeNodeFlags_SpanAvailWidth() end

---Extend hit box to the left-most and right-most edges (bypass the indented area).
---@return integer retval
function reaper.ImGui_TreeNodeFlags_SpanFullWidth() end

---Unindent()+PopID()
---@param ctx ImGui_Context
function reaper.ImGui_TreePop(ctx) end

---Indent()+PushID(). Already called by TreeNode when returning true,
---but you can call TreePush/TreePop yourself if desired.
---@param ctx ImGui_Context
---@param str_id string
function reaper.ImGui_TreePush(ctx, str_id) end

---Move content position back to the left, by 'indent_w', or
---StyleVar_IndentSpacing if 'indent_w' &lt;= 0
---@param ctx ImGui_Context
---@param indent_w? number
function reaper.ImGui_Unindent(ctx, indent_w) end

---@param ctx ImGui_Context
---@param label string
---@param size_w number
---@param size_h number
---@param v number
---@param v_min number
---@param v_max number
---@param format? string
---@param flags? integer
---@return boolean retval, number v
function reaper.ImGui_VSliderDouble(ctx, label, size_w, size_h, v, v_min, v_max, format, flags) end

---@param ctx ImGui_Context
---@param label string
---@param size_w number
---@param size_h number
---@param v integer
---@param v_min integer
---@param v_max integer
---@param format? string
---@param flags? integer
---@return boolean retval, integer v
function reaper.ImGui_VSliderInt(ctx, label, size_w, size_h, v, v_min, v_max, format, flags) end

---Return whether the pointer of the specified type is valid.Supported types are:- ImGui_Context*
---- ImGui_DrawList*
---- ImGui_DrawListSplitter*
---- ImGui_Font*
---- ImGui_Function*
---- ImGui_Image*
---- ImGui_ImageSet*
---- ImGui_ListClipper*
---- ImGui_TextFilter*
---- ImGui_Viewport*
---@param pointer identifier
---@param type string
---@return boolean 
function reaper.ImGui_ValidatePtr(pointer, type) end

---Center of the viewport.
---@param viewport ImGui_Viewport
---@return number x, number y
function reaper.ImGui_Viewport_GetCenter(viewport) end

---Main Area: Position of the viewport
---@param viewport ImGui_Viewport
---@return number x, number y
function reaper.ImGui_Viewport_GetPos(viewport) end

---Main Area: Size of the viewport.
---@param viewport ImGui_Viewport
---@return number w, number h
function reaper.ImGui_Viewport_GetSize(viewport) end

---Center of the viewport's work area.
---@param viewport ImGui_Viewport
---@return number x, number y
function reaper.ImGui_Viewport_GetWorkCenter(viewport) end

---&gt;= Viewport_GetPos
---@param viewport ImGui_Viewport
---@return number x, number y
function reaper.ImGui_Viewport_GetWorkPos(viewport) end

---&lt;= Viewport_GetSize
---@param viewport ImGui_Viewport
---@return number w, number h
function reaper.ImGui_Viewport_GetWorkSize(viewport) end

---Resize every window to its content every frame.
---@return integer retval
function reaper.ImGui_WindowFlags_AlwaysAutoResize() end

---Always show horizontal scrollbar (even if ContentSize.x &lt; Size.x).
---@return integer retval
function reaper.ImGui_WindowFlags_AlwaysHorizontalScrollbar() end

---Ensure child windows without border uses StyleVar_WindowPadding
---   (ignored by default for non-bordered child windows, because more convenient).
---@return integer retval
function reaper.ImGui_WindowFlags_AlwaysUseWindowPadding() end

---Always show vertical scrollbar (even if ContentSize.y &lt; Size.y).
---@return integer retval
function reaper.ImGui_WindowFlags_AlwaysVerticalScrollbar() end

---Allow horizontal scrollbar to appear (off by default).
---   You may use SetNextWindowContentSize(width, 0.0) prior to calling Begin() to
---   specify width. Read code in the demo's "Horizontal Scrolling" section.
---@return integer retval
function reaper.ImGui_WindowFlags_HorizontalScrollbar() end

---Has a menu-bar.
---@return integer retval
function reaper.ImGui_WindowFlags_MenuBar() end

---Disable drawing background color (WindowBg, etc.) and outside border.
---   Similar as using SetNextWindowBgAlpha(0.0).
---@return integer retval
function reaper.ImGui_WindowFlags_NoBackground() end

---Disable user collapsing window by double-clicking on it.
---   Also referred to as Window Menu Button (e.g. within a docking node).
---@return integer retval
function reaper.ImGui_WindowFlags_NoCollapse() end

---WindowFlags_NoTitleBar | WindowFlags_NoResize | WindowFlags_NoScrollbar |
---   WindowFlags_NoCollapse
---@return integer retval
function reaper.ImGui_WindowFlags_NoDecoration() end

---Disable docking of this window.
---@return integer retval
function reaper.ImGui_WindowFlags_NoDocking() end

---Disable taking focus when transitioning from hidden to visible state.
---@return integer retval
function reaper.ImGui_WindowFlags_NoFocusOnAppearing() end

---WindowFlags_NoMouseInputs | WindowFlags_NoNavInputs | WindowFlags_NoNavFocus
---@return integer retval
function reaper.ImGui_WindowFlags_NoInputs() end

---Disable catching mouse, hovering test with pass through.
---@return integer retval
function reaper.ImGui_WindowFlags_NoMouseInputs() end

---Disable user moving the window.
---@return integer retval
function reaper.ImGui_WindowFlags_NoMove() end

---WindowFlags_NoNavInputs | WindowFlags_NoNavFocus
---@return integer retval
function reaper.ImGui_WindowFlags_NoNav() end

---No focusing toward this window with gamepad/keyboard navigation
---   (e.g. skipped by CTRL+TAB).
---@return integer retval
function reaper.ImGui_WindowFlags_NoNavFocus() end

---No gamepad/keyboard navigation within the window.
---@return integer retval
function reaper.ImGui_WindowFlags_NoNavInputs() end

---Disable user resizing with the lower-right grip.
---@return integer retval
function reaper.ImGui_WindowFlags_NoResize() end

---Never load/save settings in .ini file.
---@return integer retval
function reaper.ImGui_WindowFlags_NoSavedSettings() end

---Disable user vertically scrolling with mouse wheel.
---   On child window, mouse wheel will be forwarded to the parent unless
---   NoScrollbar is also set.
---@return integer retval
function reaper.ImGui_WindowFlags_NoScrollWithMouse() end

---Disable scrollbars (window can still scroll with mouse or programmatically).
---@return integer retval
function reaper.ImGui_WindowFlags_NoScrollbar() end

---Disable title-bar.
---@return integer retval
function reaper.ImGui_WindowFlags_NoTitleBar() end

---Default flag.
---@return integer retval
function reaper.ImGui_WindowFlags_None() end

---Show the window above all non-topmost windows.
---@return integer retval
function reaper.ImGui_WindowFlags_TopMost() end

---Display a dot next to the title. When used in a tab/docking context,
---   tab is selected when clicking the X + closure is not assumed
---   (will wait for user to stop submitting the tab).
---   Otherwise closure is assumed when pressing the X,
---   so if you keep submitting the tab may reappear at end of tab bar.
---@return integer retval
function reaper.ImGui_WindowFlags_UnsavedDocument() end

---Get current button state.
---@param device integer
---@param button integer
---@return integer retval
function reaper.MCULive_GetButtonValue(device, button) end

---Get MIDI input or output dev ID. type 0 is input dev, type 1 is output dev. device &lt; 0 returns number of MCULive devices.
---@param device integer
---@param type integer
---@return integer retval
function reaper.MCULive_GetDevice(device, type) end

---Returns zero-indexed encoder parameter value. 0 = lastpos, 1 = lasttouch
---@param device integer
---@param encIdx integer
---@param param integer
---@return number retval
function reaper.MCULive_GetEncoderValue(device, encIdx, param) end

---Returns zero-indexed fader parameter value. 0 = lastpos, 1 = lasttouch, 2 = lastmove (any fader)
---@param device integer
---@param faderIdx integer
---@param param integer
---@return number retval
function reaper.MCULive_GetFaderValue(device, faderIdx, param) end

---Gets MIDI message from input buffer/queue. Gets (pops/pulls) indexed message (status, data1, data2 and frame_offset) from queue and retval is total size/length left in queue. E.g. continuously read all indiviual messages with deferred script. Frame offset resolution is 1/1024000 seconds, not audio samples. Long messages are returned as optional strings of byte characters. msgIdx -1 returns size (length) of buffer. Read also non-MCU devices by creating MCULive device with their input. 
---@param device integer
---@param msgIdx integer
---@return integer retval, integer status, integer data1, integer data2, integer frame_offset, string|nil msg
function reaper.MCULive_GetMIDIMessage(device, msgIdx) end

---Maps MCU Live device# button# to REAPER command ID. E.g. reaper.MCULive_Map(0,0x5b, 40340) maps MCU Rewind to "Track: Unsolo all tracks". Or remap button to another button if your MCU button layout doesnt play nicely with default MCULive mappings. By default range 0x00 .. 0x2d is in use. Button numbers are second column (prefixed with 0x) e.g. '90 5e' 0x5e for 'transport : play', roughly. mcu documentation: 
---mcu=&gt;pc: 
---  the mcu seems to send, when it boots (or is reset) f0 00 00 66 14 01 58 59 5a 57 18 61 05 57 18 61 05 f7 
---  ex vv vv    :   volume fader move, x=0..7, 8=master, vv vv is int14 
---  b0 1x vv    :   pan fader move, x=0..7, vv has 40 set if negative, low bits 0-31 are move amount 
---  b0 3c vv    :   jog wheel move, 01 or 41 
---  to the extent the buttons below have leds, you can set them by sending these messages, with 7f for on, 1 for blink, 0 for off. 
---  90 0x vv    :   rec arm push x=0..7 (vv:..) 
---  90 0x vv    :   solo push x=8..f (vv:..) 
---  90 1x vv    :   mute push x=0..7 (vv:..) 
---  90 1x vv    :   selected push x=8..f (vv:..) 
---  90 2x vv    :   pan knob push, x=0..7 (vv:..) 
---  90 28 vv    :   assignment track 
---  90 29 vv    :   assignment send 
---  90 2a vv    :   assignment pan/surround 
---  90 2b vv    :   assignment plug-in 
---  90 2c vv    :   assignment eq 
---  90 2d vv    :   assignment instrument 
---  90 2e vv    :   bank down button (vv: 00=release, 7f=push) 
---  90 2f vv    :   channel down button (vv: ..) 
---  90 30 vv    :   bank up button (vv:..) 
---  90 31 vv    :   channel up button (vv:..) 
---  90 32 vv    :   flip button 
---  90 33 vv    :   global view button 
---  90 34 vv    :   name/value display button 
---  90 35 vv    :   smpte/beats mode switch (vv:..) 
---  90 36 vv    :   f1 
---  90 37 vv    :   f2 
---  90 38 vv    :   f3 
---  90 39 vv    :   f4 
---  90 3a vv    :   f5 
---  90 3b vv    :   f6 
---  90 3c vv    :   f7 
---  90 3d vv    :   f8 
---  90 3e vv    :   global view : midi tracks 
---  90 3f vv    :   global view : inputs 
---  90 40 vv    :   global view : audio tracks 
---  90 41 vv    :   global view : audio instrument 
---  90 42 vv    :   global view : aux 
---  90 43 vv    :   global view : busses 
---  90 44 vv    :   global view : outputs 
---  90 45 vv    :   global view : user 
---  90 46 vv    :   shift modifier (vv:..) 
---  90 47 vv    :   option modifier 
---  90 48 vv    :   control modifier 
---  90 49 vv    :   alt modifier 
---  90 4a vv    :   automation read/off 
---  90 4b vv    :   automation write 
---  90 4c vv    :   automation trim 
---  90 4d vv    :   automation touch 
---  90 4e vv    :   automation latch 
---  90 4f vv    :   automation group 
---  90 50 vv    :   utilities save 
---  90 51 vv    :   utilities undo 
---  90 52 vv    :   utilities cancel 
---  90 53 vv    :   utilities enter 
---  90 54 vv    :   marker 
---  90 55 vv    :   nudge 
---  90 56 vv    :   cycle 
---  90 57 vv    :   drop 
---  90 58 vv    :   replace 
---  90 59 vv    :   click 
---  90 5a vv    :   solo 
---  90 5b vv    :   transport rewind (vv:..) 
---  90 5c vv    :   transport ffwd (vv:..) 
---  90 5d vv    :   transport pause (vv:..) 
---  90 5e vv    :   transport play (vv:..) 
---  90 5f vv    :   transport record (vv:..) 
---  90 60 vv    :   up arrow button  (vv:..) 
---  90 61 vv    :   down arrow button 1 (vv:..) 
---  90 62 vv    :   left arrow button 1 (vv:..) 
---  90 63 vv    :   right arrow button 1 (vv:..) 
---  90 64 vv    :   zoom button (vv:..) 
---  90 65 vv    :   scrub button (vv:..) 
---  90 6x vv    :   fader touch x=8..f 
---  90 70 vv    :   master fader touch 
---pc=&gt;mcu: 
---  f0 00 00 66 14 12 xx &lt;data&gt; f7   : update lcd. xx=offset (0-112), string. display is 55 chars wide, second line begins at 56, though. 
---  f0 00 00 66 14 08 00 f7          : reset mcu 
---  f0 00 00 66 14 20 0x 03 f7       : put track in vu meter mode, x=track   
---  90 73 vv : rude solo light (vv: 7f=on, 00=off, 01=blink) 
---  b0 3x vv : pan display, x=0..7, vv=1..17 (hex) or so 
---  b0 4x vv : right to left of leds. if 0x40 set in vv, dot below char is set (x=0..11) 
---  d0 yx    : update vu meter, y=track, x=0..d=volume, e=clip on, f=clip off 
---  ex vv vv : set volume fader, x=track index, 8=master 
---
---@param device integer
---@param button integer
---@param bool? integer
---@return integer retval
function reaper.MCULive_Map(device, button, bool) end

---Reset device. device &lt; 0 resets all and returns number of devices.
---@param device integer
---@return integer retval
function reaper.MCULive_Reset(device) end

---Sends MIDI message to device. If string is provided, individual bytes are not sent. Returns number of sent bytes.
---@param device integer
---@param status integer
---@param data1 integer
---@param data2 integer
---@param msg? string
---@return integer retval
function reaper.MCULive_SendMIDIMessage(device, status, data1, data2, msg) end

---Set button as MIDI passthrough.
---@param device integer
---@param button integer
---@param isSet boolean
---@return integer retval
function reaper.MCULive_SetButtonPassthrough(device, button, isSet) end

---Buttons function as press only by default. Set false for press and release function.
---@param device integer
---@param button integer
---@param isSet boolean
---@return integer retval
function reaper.MCULive_SetButtonPressOnly(device, button, isSet) end

---Set button led/mode/state. Value 0 = off,1 = blink, 0x7f = on, usually.
---@param device integer
---@param button integer
---@param value integer
---@return integer retval
function reaper.MCULive_SetButtonValue(device, button, value) end

---Enables/disables default out-of-the-box operation.
---@param device integer
---@param isSet boolean
function reaper.MCULive_SetDefault(device, isSet) end

---Write to display. 112 characters, 56 per row.
---@param device integer
---@param pos integer
---@param message string
---@param pad integer
function reaper.MCULive_SetDisplay(device, pos, message, pad) end

---Set encoder to value 0 ... 1.0. Type 0 = linear, 1 = track volume, 2 = pan. Returns scaled value.
---@param device integer
---@param encIdx integer
---@param val number
---@param type integer
---@return integer retval
function reaper.MCULive_SetEncoderValue(device, encIdx, val, type) end

---Set fader to value 0 ... 1.0. Type 0 = linear, 1 = track volume, 2 = pan. Returns scaled value.
---@param device integer
---@param faderIdx integer
---@param val number
---@param type integer
---@return integer retval
function reaper.MCULive_SetFaderValue(device, faderIdx, val, type) end

---Set meter value 0 ... 1.0. Type 0 = linear, 1 = track volume (with decay).
---@param device integer
---@param meterIdx integer
---@param val number
---@param type integer
---@return integer retval
function reaper.MCULive_SetMeterValue(device, meterIdx, val, type) end

---1 : surface split point device index 
---2 : 'mode-is-global' bitmask/flags, first 6 bits
---@param option integer
---@param value integer
function reaper.MCULive_SetOption(option, value) end
