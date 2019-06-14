using Revise

@async while(true)
    if !isempty(Revise.revision_queue)
        Revise.revise()
    end
    sleep(1/3)
end
