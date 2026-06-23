local M = {}

local state = {
}

local create_exit_terminal_fn = function(bufnr)
	return function()
		vim.api.nvim_win_close(instance.win, true)
		vim.api.nvim_buf_delete(instance.buf, { force = true })
        state[bufnr] = nil
	end
end

local new_terminal_instance = function()
	local ti = {
		buf = nil,
		win = nil,
		chan = nil,
		on = false,
	}
	ti.buf = vim.api.nvim_create_buf(true, true)
    state[buf] = ti
	return ti.buf
end

M.list_terminals = function()
    local list = {}
    for _, v in pairs(state) do
        table.insert(list, v)
    end
    return list
end

M.attach_to_terminal = function(bufnr)
    if state[bufnr].on then
        return
    end
	state[bufnr].win = vim.api.nvim_open_win(
		state[bufnr].buf,
		true,
		{ relative = "editor", row = 0, col = 0, width = columns, height = lines }
	)
    state[bufnr].on = true
	vim.w.winfixbuf = true
	vim.api.nvim_create_autocmd("WinClosed", {
		pattern = "" .. state[bufnr].win,
		callback = function()
			state[bufnr].win = nil
			state[bufnr].on = false
		end,
	})
end

M.toggle_terminal = function(instance, opts)
	local cmd = vim.o.shell
	if opts.args ~= "" and opts.args ~= nil then
		cmd = opts.args
	end
	if instance.on ~= true then
		instance.on = true
		local lines = vim.o.lines
		local columns = vim.o.columns
		if instance.buf == nil or not vim.api.nvim_buf_is_valid(instance.buf) then
			instance.buf = vim.api.nvim_create_buf(true, true)
		end
		if instance.win ~= nil then
			vim.api.nvim_set_current_win(instance.win)
		else
			instance.win = vim.api.nvim_open_win(
				instance.buf,
				true,
				{ relative = "editor", row = 0, col = 0, width = columns, height = lines }
			)
			vim.w.winfixbuf = true
			vim.api.nvim_create_autocmd("WinClosed", {
				pattern = "" .. instance.win,
				callback = function()
					instance.win = nil
					instance.on = false
				end,
			})
		end

		local buftype = vim.bo[instance.buf].buftype
		if buftype ~= "terminal" then
			instance.chan = vim.fn.jobstart({ cmd }, { term = true, on_exit = create_exit_terminal_fn(instance) })
			vim.cmd.startinsert()
		end
	else
		local curwin = vim.api.nvim_get_current_win()
		if instance.win == curwin then
			vim.api.nvim_win_close(instance.win, true)
			instance.win = nil
			instance.on = false
		end
	end
end
vim.api.nvim_create_user_command("T", function(opts)
	M.toggle_terminal(opts)
end, { nargs = "?" })
return M
