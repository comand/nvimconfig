local status_ok, comment = pcall(require, "impatient")
if not status_ok then
    return
end

impatient.enable_profile()
