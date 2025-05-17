<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ResourceProfiledesign extends Model
{
    use HasFactory;
    protected $table = 'resource-profiledesign';

    protected $fillable = [
        'resource_profile_design_categorie_id', 'designName', 'content', 'designPrice', 'category', 'format',
        'isPrivate', 'sections', 'version', 'sectionOrder', 'sectionDefault', 'sectionColumn',
        'isDownload', 'author', 'rating', 'downloadTimes', 'web', 'app', 'heading',
        'color1', 'color2', 'color3', 'color4', 'basevalue', 'headText', 'timeLine',
        'timeLineSmall', 'timeSubLine', 'headLine', 'subLine', 'baseLine', 'introLine',
        'nameLine', 'nameHeight', 'introHeight', 'headLineHeight', 'headerLineHeight', 'GenLine',
        'logo', 'template', 'status'
    ];

    public function resourceProfileDesignCategory()
    {
        return $this->belongsTo(ResourceProfileDesignCategory::class, 'resource_profile_design_categorie_id', 'id');
    }
}
