/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

zrush = zrush or {}
zrush.vgui = zrush.vgui or {}

if SERVER then
    // Forces the interface to be closed
    util.AddNetworkString("zrush_vgui_forceclose")
    function zrush.vgui.ForceClose(ply)
    	net.Start("zrush_vgui_forceclose")
    	net.Send(ply)
    end
else
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

    // This closes the machine ui for a user
    net.Receive("zrush_vgui_forceclose", function(len)
        zrush.vgui.Close()
    end)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
