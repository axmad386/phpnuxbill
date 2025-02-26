{include file="sections/header.tpl"}

<div class="row">
    <div class="col-sm-12 col-md-12">
        <div class="panel panel-primary panel-hovered panel-stacked mb30">
            <div class="panel-heading">{$_L['Edit_Plan']} || {$d['name_plan']}</div>
            <div class="panel-body">
                <form class="form-horizontal" method="post" role="form" action="{$_url}services/edit-post">
                    <input type="hidden" name="id" value="{$d['id']}">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Status')}</label>
                        <div class="col-md-10">
                                <input type="radio" name="enabled" value="1" {if $d['enabled'] == 1}checked{/if}> Enable
                                <input type="radio" name="enabled" value="0" {if $d['enabled'] == 0}checked{/if}> Disable
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Client Can Purchase')}</label>
                        <div class="col-md-10">
                            <input type="radio" name="allow_purchase" value="yes" {if $d['allow_purchase'] == yes}checked{/if}> Yes
                            <input type="radio" name="allow_purchase" value="no" {if $d['allow_purchase'] == no}checked{/if}> No
                        </div>
                    </div>
                    {if $_c['radius_enable'] and $d['is_radius']}
                        <div class="form-group">
                            <label class="col-md-2 control-label">Radius</label>
                            <div class="col-md-10">
                                <label class="label label-primary">RADIUS</label>
                            </div>
                        </div>
                    {/if}
                    <div class="form-group">
                        <label class="col-md-2 control-label">{$_L['Plan_Name']}</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="name" name="name" maxlength="40"
                                value="{$d['name_plan']}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{$_L['Plan_Type']}</label>
                        <div class="col-md-10">
                            <input type="radio" id="Unlimited" name="typebp" value="Unlimited"
                                {if $d['typebp'] eq 'Unlimited'} checked {/if}> {$_L['Unlimited']}
                            <input type="radio" id="Limited" {if $_c['radius_enable'] and $d['is_radius']}disabled{/if}
                                name="typebp" value="Limited" {if $d['typebp'] eq 'Limited'} checked {/if}>
                            {$_L['Limited']}
                        </div>
                    </div>
                    <div {if $d['typebp'] eq 'Unlimited'} style="display:none;" {/if} id="Type">
                        <div class="form-group">
                            <label class="col-md-2 control-label">{$_L['Limit_Type']}</label>
                            <div class="col-md-10">
                                <input type="radio" id="Time_Limit" name="limit_type" value="Time_Limit"
                                    {if $d['limit_type'] eq 'Time_Limit'} checked {/if}> {$_L['Time_Limit']}
                                <input type="radio" id="Data_Limit" name="limit_type" value="Data_Limit"
                                    {if $d['limit_type'] eq 'Data_Limit'} checked {/if}> {$_L['Data_Limit']}
                                <input type="radio" id="Both_Limit" name="limit_type" value="Both_Limit"
                                    {if $d['limit_type'] eq 'Both_Limit'} checked {/if}> {$_L['Both_Limit']}
                            </div>
                        </div>
                    </div>
                    <div {if $d['typebp'] eq 'Unlimited'} style="display:none;"
                    {elseif ($d['time_limit']) eq '0'}
                        style="display:none;" {/if} id="TimeLimit">
                        <div class="form-group">
                            <label class="col-md-2 control-label">{$_L['Time_Limit']}</label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="time_limit" name="time_limit"
                                    value="{$d['time_limit']}">
                            </div>
                            <div class="col-md-2">
                                <select class="form-control" id="time_unit" name="time_unit">
                                    <option value="Hrs" {if $d['time_unit'] eq 'Hrs'} selected {/if}>{$_L['Hrs']}
                                    </option>
                                    <option value="Mins" {if $d['time_unit'] eq 'Mins'} selected {/if}>{$_L['Mins']}
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div {if $d['typebp'] eq 'Unlimited'} style="display:none;"
                    {elseif ($d['data_limit']) eq '0'}
                        style="display:none;" {/if} id="DataLimit">
                        <div class="form-group">
                            <label class="col-md-2 control-label">{$_L['Data_Limit']}</label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="data_limit" name="data_limit"
                                    value="{$d['data_limit']}">
                            </div>
                            <div class="col-md-2">
                                <select class="form-control" id="data_unit" name="data_unit">
                                    <option value="MB" {if $d['data_unit'] eq 'MB'} selected {/if}>MBs</option>
                                    <option value="GB" {if $d['data_unit'] eq 'GB'} selected {/if}>GBs</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label"><a
                                href="{$_url}bandwidth/add">{$_L['BW_Name']}</a></label>
                        <div class="col-md-6">
                            <select id="id_bw" name="id_bw" class="form-control select2">
                                {foreach $b as $bs}
                                    <option value="{$bs['id']}" {if $d['id_bw'] eq $bs['id']} selected {/if}>
                                        {$bs['name_bw']}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{$_L['Plan_Price']}</label>
                        <div class="col-md-6">
                            <div class="input-group">
                                <span class="input-group-addon">{$_c['currency_code']}</span>
                                <input type="number" class="form-control" name="price" value="{$d['price']}" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{$_L['Shared_Users']}</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="sharedusers" name="sharedusers"
                                value="{$d['shared_users']}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{$_L['Plan_Validity']}</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="validity" name="validity"
                                value="{$d['validity']}">
                        </div>
                        <div class="col-md-2">
                            <select class="form-control" id="validity_unit" name="validity_unit">
                                <option value="Mins" {if $d['validity_unit'] eq 'Mins'} selected {/if}>{$_L['Mins']}
                                </option>
                                <option value="Hrs" {if $d['validity_unit'] eq 'Hrs'} selected {/if}>{$_L['Hrs']}
                                </option>
                                <option value="Days" {if $d['validity_unit'] eq 'Days'} selected {/if}>{$_L['Days']}
                                </option>
                                <option value="Months" {if $d['validity_unit'] eq 'Months'} selected {/if}>
                                    {$_L['Months']}</option>
                            </select>
                        </div>
                    </div>
                    <span id="routerChoose" class="{if $d['is_radius']}hidden{/if}">
                        <div class="form-group">
                            <label class="col-md-2 control-label"><a
                                    href="{$_url}routers/add">{$_L['Router_Name']}</a></label>
                            <div class="col-md-6">
                                <input type="text" class="form-control" id="routers" name="routers"
                                    value="{$d['routers']}" readonly>
                            </div>
                        </div>
                    </span>
                    <div class="form-group">
                        <label class="col-md-2 control-label"><a
                                href="{$_url}pool/add">{Lang::T('Expired IP Pool')}</a></label>
                        <div class="col-md-6">
                            <select id="pool_expired" name="pool_expired" class="form-control select2">
                                <option value=''>{$_L['Select_Pool']}</option>
                                {foreach $p as $ps}
                                    <option value="{$ps['pool_name']}" {if $d['pool_expired'] eq $ps['pool_name']} selected
                                        {/if}>{$ps['pool_name']}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <button class="btn btn-success waves-effect waves-light"
                                type="submit">{$_L['Save']}</button>
                            Or <a href="{$_url}services/hotspot">{$_L['Cancel']}</a>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

{if $_c['radius_enable']}
    {literal}
        <script>
            function isRadius(cek) {
                if (cek.checked) {
                    $("#routerChoose").addClass('hidden');
                    document.getElementById("routers").required = false;
                    document.getElementById("Limited").disabled = true;
                } else {
                    document.getElementById("Limited").disabled = false;
                    document.getElementById("routers").required = true;
                    $("#routerChoose").removeClass('hidden');
                }
            }
            setTimeout(() => {
                $.ajax({
                    url: "index.php?_route=autoload/pool",
                    data: "routers=radius",
                    cache: false,
                    success: function(msg) {
                        $("#pool_expired").html(msg);
                    }
                });
            }, 2000);
        </script>
    {/literal}
{/if}
{include file="sections/footer.tpl"}
